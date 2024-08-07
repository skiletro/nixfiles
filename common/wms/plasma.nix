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
      ark
      elisa
      gwenview
      okular
      kate
      khelpcenter
    ];

    environment.systemPackages = with pkgs; [
      libsForQt5.polonium # Tiling KWin Script
    ];

    services.tlp.enable = lib.mkForce false; # KDE power management takes priority over `tlp`
  };
}
