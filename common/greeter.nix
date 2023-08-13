{ config, pkgs, ... }:

let
  swayConf = pkgs.writeText "greetd-sway-config" ''
    exec "dbus-update-activation-environment --systemd WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"

    xwayland disable

    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?'
      -b 'Power off' 'systemctl poweroff' \
      -b 'Reboot 'systemctl reboot'

    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet --layer-shell --command=Hyprland; swaymsg exit"
  '';
in {
  services.greetd = {
    enable = true;
    package = pkgs.greetd.gtkgreet;
    settings = rec {
      default_session = {
        # command = "${pkgs.sway}/bin/sway --config ${swayConf}";
        command =
          "dbus-run-session ${pkgs.cage}/bin/cage -s -- " +
          "${pkgs.greetd.gtkgreet}/bin/gtkgreet --layer-shell --command=Hyprland";
        user = "jamie";
      };
    };
  };
}
