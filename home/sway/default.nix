{
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "fuzzel";
      gaps = {
        outer = 5;
        inner = 5;
      };
      keybindings = let
        m = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${m}+Return" = "exec ${terminal}";
          "${m}+d" = "exec ${menu}";
          "${m}+t" = "split toggle";

          "${m}+Left" = "focus left";
          "${m}+Down" = "focus down";
          "${m}+Up" = "focus up";
          "${m}+Right" = "focus right";

          # function keys
          "XF86MonBrightnessDown" = "exec light -U 10";
          "XF86MonBrightnessUp" = "exec light -A 10";
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          # screenshots
          "Print" = "exec flameshot gui";
          "Alt+Print" = "exec ''grim - | wl-copy -t image/png''";
        };
      output = {
        eDP-1 = {
          scale = "1.5";
        };
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "gb";
        };
        "type:touchpad" = {
          tap = "enabled";
          dwt = "false";
        };
      };
    };
  };
}
