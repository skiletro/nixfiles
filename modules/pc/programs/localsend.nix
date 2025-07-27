{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.eos.programs.graphical.enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };

    home-manager.sharedModules = lib.singleton {
      xdg.autostart.entries = [
        (
          (pkgs.makeDesktopItem {
            desktopName = "LocalSend Autostart";
            name = "localsend-autostart";
            destination = "/";
            noDisplay = true;
            exec = "${lib.getExe config.programs.localsend.package} --hidden";
          })
          + /localsend-autostart.desktop
        )
      ];
    };
  };
}
