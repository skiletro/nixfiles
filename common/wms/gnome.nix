{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (builtins.elem "gnome" config.userConfig.desktop.environments) {
    userConfig.services = {
      syncthing.enable = true;
    };
    userConfig.desktop.isWayland = true;

    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages =
      (with pkgs; [
        gnome-tour
      ])
      ++ (with pkgs.gnome; [
        epiphany # web browser
        geary # email reader
        evince # document viewer
      ]);

    services.tlp.enable = lib.mkForce false; # Gnome power management takes priority over `tlp`
  };
}
