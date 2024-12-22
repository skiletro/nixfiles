{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (builtins.elem "hyprland" config.userConfig.desktop.environments) {
    userConfig.services = {
      xdg.enable = true;

      eww.enable = true;
      rofi.enable = true;
      swaylock.enable = true;
      swaync.enable = true;
      wlogout.enable = true;
    };

    programs.hyprland.enable = true; # Required to enable critical components needed to run Hyprland properly
    services.gnome.gnome-keyring.enable = true; # Saves passwords
    services.gvfs.enable = true; # For Nautilus

    services.blueman.enable = true; # Bluetooth manager since Hyprland doens't have a built in one

    environment.systemPackages = with pkgs; [
      gnome.nautilus # File Manager
      gnome.eog # Image Viewer
      gnome.file-roller # Archive Viewer
      gnome.gnome-font-viewer # Font Viewer
      pavucontrol # Volume Control
      gnome-music # Music Player

      wlsunset # Blue-light Filter
      xdg-utils
      networkmanagerapplet # Access network from tray
      grimblast # Screenshotter
    ];

    # The rest of Hyprland settings can be found in home manager config
  };
}
