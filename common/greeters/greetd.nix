{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf ((config.userConfig.greeter.enable)
    && (config.userConfig.greeter.type == "greetd")) {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "jamie";
          command = let
            swayConf = pkgs.writeText "greetd-sway-config" ''
              output eDP-1 scale 1.25
              output eDP-1 background #1e1e2e solid_color

              exec "dbus-update-activation-environment --systemd WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"
              exec "eww daemon"

              input "type:touchpad" {
                tap enabled
              }

              bindsym XF86MonBrightnessUp exec bash ~/.config/eww/launchers/set-brightness up
              bindsym XF86MonBrightnessDown exec bash ~/.config/eww/launchers/set-brightness down

              xwayland disable

              exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
            '';
          in "${pkgs.sway}/bin/sway --config ${swayConf}";
        };
      };
    };

    security.pam.services.greetd.enableGnomeKeyring = true;

    environment.etc."greetd/environments".text = ''
      Hyprland
    '';
  };
}
