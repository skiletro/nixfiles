{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.services.syncthing.enable {
    services.syncthing = {
      enable = true;
      tray = {
        enable = true;
        package = pkgs.syncthingtray;
        command = "syncthingtray --wait";
      };
    };

    systemd.user.services.${config.services.syncthing.tray.package.pname} = {
      Install.WantedBy = lib.mkForce [];
    };

    systemd.user.timers.${config.services.syncthing.tray.package.pname} = {
      Timer = {
        OnActiveSec = "6s";
        AccuracySec = "1s";
      };
      Install = {WantedBy = ["graphical-session.target"];};
    };
  };
}
