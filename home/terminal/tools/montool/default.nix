{pkgs, ...}: {
  home.packages = let
    montool = pkgs.writeShellScriptBin "montool" ''
        toggle_bar() {
          eww close bar
          eww open bar
        }

        toggle_on() {
          hyprctl keyword monitor "DP-1, 1920x1080@120, auto, 1"
          hyprctl keyword monitor "eDP-1, disable"
          sleep 1.5
          toggle_bar
        }

        toggle_off() {
          hyprctl reload
          sleep 1.5
          toggle_bar
        }

        case "$1" in
          on)
            toggle_on >/dev/null
            echo "Done!"
          ;;

          off)
            toggle_off >/dev/null
            echo "Done!"
          ;;

          *)
          cat <<-EOF
      montool - quick script written to toggle laptop screen on and off

      Commands:
        on    Turn off laptop and turn on dedicated monitor
        off   Turn back on laptop monitor
      EOF
          ;;
        esac
    '';
  in
    with pkgs; [montool];
}
