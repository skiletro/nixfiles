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

    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs; [
      epiphany
      geary
      gnome-connections
      gnome-contacts
      gnome-console
      gnome-maps
      gnome-tour
      gnome-software
      gnome-weather
      seahorse
      simple-scan
      totem
      yelp
    ];
    services.tlp.enable = lib.mkForce false; # Gnome power management takes priority over `tlp`

    environment.systemPackages =
      (with pkgs; [
        adwaita-icon-theme # fixes some missing icons
        mission-center
      ])
      ++ (with pkgs.gnomeExtensions; [
        blur-my-shell
        dash-to-dock
        mpris-label
      ]);
  };
}
