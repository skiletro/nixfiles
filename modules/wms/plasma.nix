{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (builtins.elem "plasma" config.userConfig.desktop.environments) {
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      khelpcenter
    ];

    environment.systemPackages =
      (with pkgs; [
        adwaita-icon-theme # Fixes some issues with Adwaita apps
        applet-window-title # Shows the application title and icon for active window
        flameshot # Spectacle screenshoting tool replacement
        gparted # Partition Manager
        haruna # Video Player
        nur.repos.xddxdd.vk-hdr-layer # HDR for Vulkan
        nur.repos.shadowrz.klassy-qt6
        nur.repos.skiletro.applet-darwinmenu # macOS-like "start menu"
        nur.repos.skiletro.applet-kara # Workspace indicator
      ])
      ++ (with pkgs.kdePackages; [
        kcalc # Calculator
        qtwebengine # Web engine based on the Chromium web browser
        filelight # Disk usage statistics
        kzones # KWin script for snapping windows into zones
      ]);

    services.tlp.enable = lib.mkForce false; # KDE power management takes priority over `tlp`
  };
}
