{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  wayland.windowManager.hyprland = lib.mkIf (osConfig.networking.hostName == "themis") {
    extraConfig = ''
      monitor = eDP-1, 1920x1080@60, 0x0, 1.25
      monitor = DP-1, 1920x1080@144, 1920x0, 1
    '';

    settings = {
      exec-once = [
        "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 24c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1.25"
      ];

      env = [
        "GDK_SCALE, 1.25"
        "QT_SCALE_FACTOR, 1.25"
        "ELM_SCALE, 1.25"
      ];
    };
  };
}
