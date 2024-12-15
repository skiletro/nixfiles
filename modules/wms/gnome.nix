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
      gnome-terminal
      gnome-tour
    ];
    services.tlp.enable = lib.mkForce false; # Gnome power management takes priority over `tlp`

    environment.systemPackages =
      (with pkgs; [
        adwaita-icon-theme # fixes some missing icons
      ])
      ++ (with pkgs.gnomeExtensions; [
        appindicator
        dash-to-dock
        openweather-refined
        mpris-label
        search-light
        # no-overview # causing a lot of crashing
        status-area-horizontal-spacing
      ]);

    # TODO: Need to enable in HM at some point
    # dconf.settings = with lib.hm.gvariant; {
    #      "org/gnome/mutter".experimental-features = ["scale-monitor-framebuffer"]; # Enable other scaling modes
    # };
  };
}
