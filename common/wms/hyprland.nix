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
      syncthing.enable = true;
      wlogout.enable = true;
    };

    programs.hyprland.enable = true; # Required to enable critical components needed to run Hyprland properly
    services.gnome.gnome-keyring.enable = true; # Saves passwords

    services.blueman.enable = true; # Bluetooth manager since Hyprland doens't have a built in one

    environment.systemPackages = with pkgs; [
      gnome.nautilus
      gnome.eog
      gnome.file-roller
      gnome.gnome-font-viewer
      pavucontrol
    ];

    # The rest of Hyprland settings can be found in home manager config
  };
}
