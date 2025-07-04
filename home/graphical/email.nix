{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.enable {
    home.packages = with pkgs; [
      thunderbird
    ];

    systemd.user.services."protonmail-bridge" = {
      Unit.Description = "ProtonMail Bridge";
      Service = {
        ExecStart = "${lib.getExe pkgs.protonmail-bridge} -n";
        Restart = "on-failure";
        RestartSec = 10;
        Slice = "background.slice";
      };
      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
