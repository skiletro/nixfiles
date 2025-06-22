{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.eos.services.rclone.enable {
    age.secrets.rclone-protondrive = {
      file = ../../../secrets/rclone-protondrive.age;
      owner = "root";
      group = "root";
      mode = "600";
    };

    systemd.services."rclone-documents-sync" = {
      after = ["run-agenix.d.mount"];
      wants = ["run-agenix.d.mount"];
      serviceConfig = {
        Type = "oneshot";
        User = config.eos.system.user;
        LoadCredential = ["target:${config.age.secrets.rclone-protondrive.path}"];
        Environment = ["CONF=%d/target"];
      };
      script =
        # sh
        ''
          ${lib.getExe pkgs.rclone} bisync proton:Documents /home/${config.eos.system.user}/Documents/ -v --force --min-size 1b --max-lock 90m --resync --config=''${CONF}
        '';
      startAt = "*:0/10"; # Every 10 minutes
    };
  };
}
