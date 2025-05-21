# Use https://github.com/noisetorch/NoiseTorch/wiki/Start-automatically-with-Systemd to find your deviceUnit and deviceID
{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.eos.services.noisetorch;
  nt = "${lib.getExe pkgs.noisetorch}";
  inherit (lib) mkEnableOption mkOption mkIf types;
in {
  options.eos.services.noisetorch = {
    enable = mkEnableOption ''NoiseTorch (+ setcap wrapper), a virtual microphone device with noise suppression, with a systemd service configured declaratively.'';
    deviceUnit = mkOption {
      type = types.str;
      description = "Specify the microphone systemd device unit. This is done to prevent the NoiseTorch service from loading before the mic becomes available.";
    };
    deviceID = mkOption {
      type = types.str;
      description = "Specify the microphone device ID.";
    };
  };

  config = mkIf cfg.enable {
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
