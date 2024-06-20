{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.windowManager.hyprland.scaling.enable {
    wayland.windowManager.hyprland = let
      scale = toString osConfig.userConfig.windowManager.hyprland.scaling.multiplier;
    in {
      extraConfig = ''
        monitor = eDP-1, 1920x1080@60, 0x0, ${scale}
        monitor = DP-1, 1920x1080@120, 1920x0, 1
      '';

      settings = {
        env = [
          "GDK_SCALE, ${scale}"
          "QT_SCALE_FACTOR, ${scale}"
          "ELM_SCALE, ${scale}"
        ];
      };
    };
  };
}
