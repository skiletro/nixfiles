{ config, pkgs, lib, ... }:

let
  swayConf = pkgs.writeText "greetd-sway-config" ''
    output eDP-1 scale 1.5
    output eDP-1 background #1e1e2e solid_color
    
    exec "dbus-update-activation-environment --systemd WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"

    input "type:touchpad" {
      tap enabled
    }

    xwayland disable

    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?'
      -b 'Power off' 'systemctl poweroff' \
      -b 'Reboot 'systemctl reboot'

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
