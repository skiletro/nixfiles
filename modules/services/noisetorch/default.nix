# Use https://github.com/noisetorch/NoiseTorch/wiki/Start-automatically-with-Systemd to find your deviceUnit and deviceID
{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userConfig.services.noisetorch;
  nt = "${pkgs.noisetorch}/bin/noisetorch";
in {
  options.userConfig.services.noisetorch = {
    enable = lib.mkEnableOption ''NoiseTorch (+ setcap wrapper), a virtual microphone device with noise suppression, with a systemd service configured declaratively.'';
    deviceUnit = lib.mkOption {
      type = lib.types.str;
      description = "Specify the microphone systemd device unit. This is done to prevent the NoiseTorch service from loading before the mic becomes available.";
    };
    deviceID = lib.mkOption {
      type = lib.types.str;
      description = "Specify the microphone device ID.";
    };
  };

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
      requires = [cfg.deviceUnit];
      after = ["pipewire.service" cfg.deviceUnit];
      serviceConfig = {
        Type = "simple";
        RemainAfterExit = "yes";
        ExecStart = ''${nt} -s ${cfg.deviceID} -i -o'';
        ExecStop = ''${nt} -u'';
        Restart = "on-failure";
        RestartSec = 3;
      };
    };
  };
}
