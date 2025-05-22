{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.eos.services.noisetorch;
  nt = "${lib.getExe pkgs.noisetorch}";
in {
  config = lib.mkIf cfg.enable {
    security.wrappers.noisetorch = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_resource=+ep";
      source = nt;
    };

    systemd.user.services.noisetorch = {
      enable = true;
      description = "NoiseTorch Audio Cancelling";
      wantedBy = ["default.target"];
      after = ["pipewire.service"];
      serviceConfig = {
        Type = "simple";
        RemainAfterExit = "yes";
        ExecStart = ''${nt} -s ${cfg.deviceID} -i -t 75 -o'';
        ExecStop = ''${nt} -u'';
        Restart = "on-failure";
        RestartSec = 3;
      };
    };
  };
}
