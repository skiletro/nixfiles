{pkgs, ...}: let
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
in {
  services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config ${swayConf}";
        user = "jamie";
      };
    };
  };

  security.pam.services.greetd.enableGnomeKeyring = true;

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
}
