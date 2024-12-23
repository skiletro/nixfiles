{
  pkgs,
  lib,
  config,
  inputs,
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
    ];
    services.tlp.enable = lib.mkForce false; # Gnome power management takes priority over `tlp`

    environment.systemPackages =
      (with pkgs; [
        adwaita-icon-theme # fixes some missing icons
        mission-center # Task Manager
        showtime # Video Player (Totem replacement)
      ])
      ++ (with pkgs.gnomeExtensions; [
        appindicator
        dash-to-dock
        mpris-label
      ])
      ++ (
        if config.userConfig.gaming.enable
        then [pkgs.gnomeExtensions.gamemode-shell-extension]
        else []
      );

    services.udev.packages = [pkgs.gnome-settings-daemon];

    nixpkgs.overlays = [
      (_final: prev: {
        mutter = prev.mutter.overrideAttrs (_oldAttrs: {
          src = inputs.mutter-triple-buffering-src;
          preConfigure = ''
            cp -a "${inputs.gvdb-src}" ./subprojects/gvdb
          '';
        });
      })
    ];
  };
}
