{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.eos.services.rclone.enable {
    age.secrets."rclone-protondrive.conf" = {
      file = ../../../secrets/rclone-protondrive.age;
      mode = "400";
      owner = config.eos.system.user;
    };

    systemd.services."rclone-documents-sync" = {
      after = ["run-agenix.d.mount"];
      wants = ["run-agenix.d.mount"];
      serviceConfig = {
        Type = "oneshot";
        User = config.eos.system.user;
        ExecStart = lib.getExe (pkgs.writeShellScriptBin "rclone-documents-sync"
          # sh
          ''
            ${lib.getExe pkgs.rclone} bisync --config="/run/agenix/rclone-protondrive.conf" -v --force --min-size 1b --max-lock 90m --resync proton:Documents /home/${config.eos.system.user}/Documents/
          '');
      };
      startAt = "*:0/10"; # Every 10 minutes
    };
  };
}
