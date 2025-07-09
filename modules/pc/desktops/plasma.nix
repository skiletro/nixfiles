{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.eos.system.desktop == "plasma") {
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      khelpcenter
    ];

    home-manager.sharedModules = lib.singleton {
      stylix.iconTheme = {
        enable = true;
        package = pkgs.colloid-icon-theme;
        dark = "Colloid-Dark";
        light = "Colloid-Light";
      };

      dconf = {
        enable = true;
        settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
      };
    };

    environment.systemPackages =
      (with pkgs; [
        adwaita-icon-theme # Fixes some issues with Adwaita apps
        applet-window-title # Shows the application title and icon for active window
        flameshot # Spectacle screenshoting tool replacement
        gparted # Partition Manager
        haruna # Video Player
        qdirstat # Disk usage statistics
        #nur.repos.shadowrz.klassy-qt6
        nur.repos.skiletro.applet-darwinmenu # macOS-like "start menu"
        nur.repos.skiletro.applet-kara # Workspace indicator
        plasmusic-toolbar # Better media player widget
      ])
      ++ (with pkgs.kdePackages; [
        kcalc # Calculator
        qtwebengine # Web engine based on the Chromium web browser
        kzones # KWin script for snapping windows into zones
      ]);

    services.tlp.enable = lib.mkForce false; # KDE power management takes priority over `tlp`
  };
}
