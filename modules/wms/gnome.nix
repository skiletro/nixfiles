{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (builtins.elem "gnome" config.userConfig.desktop.environments) {
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
    ];
    services.tlp.enable = lib.mkForce false; # Gnome power management takes priority over `tlp`

    environment.systemPackages =
      (with pkgs; [
        adwaita-icon-theme # fixes some missing icons
        mission-center
      ])
      ++ (with pkgs.gnomeExtensions; [
        appindicator
        dash-to-dock
        mpris-label
      ]);

    services.udev.packages = [pkgs.gnome-settings-daemon];
  };
}
