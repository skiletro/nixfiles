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
        gparted # Partition Manager
        haruna # Video Player
        polonium # Tiling KWin Script
        qdirstat # Graphical Disk Usage Analyzer
      ])
      ++ (with pkgs.kdePackages; [
        kcalc # Calculator
      ]);

    services.tlp.enable = lib.mkForce false; # KDE power management takes priority over `tlp`
  };
}
