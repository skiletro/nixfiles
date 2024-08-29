{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (builtins.elem "plasma" config.userConfig.desktop.environments) {
    userConfig.services = {
      syncthing.enable = true;
    };
    userConfig.desktop.isWayland = true;

    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      elisa
      khelpcenter
    ];

    environment.systemPackages =
      (with pkgs; [
        polonium # Tiling KWin Script
      ])
      ++ (with pkgs.kdePackages; [
        kcalc # Calculator
      ]);

    services.tlp.enable = lib.mkForce false; # KDE power management takes priority over `tlp`
  };
}
