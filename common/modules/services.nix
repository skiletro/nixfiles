{
  lib,
  config,
  ...
}: {
  options = {
    userConfig.services = {
      xdg.enable = lib.mkEnableOption "XDG Settings";
      theming.enable = lib.mkEnableOption "Declarative theming for standalone WMs and Compositors";

      eww.enable = lib.mkEnableOption "Eww";
      rofi.enable = lib.mkEnableOption "Rofi";
      swaylock.enable = lib.mkEnableOption "Swaylock";
      swaync.enable = lib.mkEnableOption "Sway Notification Center";
      syncthing.enable = lib.mkEnableOption "Syncthing and Syncthingtray";
      wlogout.enable = lib.mkEnableOption "Wlogout";
    };
  };
}
