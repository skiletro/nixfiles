{pkgs, ...}: {
  home.packages = [pkgs.wlogout];

  xdg.configFile."wlogout/style.css".text = ''
     * {
       all: unset;
       font-family: sans-serif;
     }

     window {
       background-color: #1e1e2e;
     }

     button {
       color: #313244;
       font-size: 64px;
       background-color: rgba(0,0,0,0);
       outline-style: none;
       margin: 5px;
    }

     button:focus, button:active, button:hover {
       color: #cba7fa;
       transition: ease 0.4s;
     }
  '';

  xdg.configFile."wlogout/layout".text = let
    swaylock = pkgs.writeShellScript "swaylock-script" ''
      ${pkgs.swaylock-effects}/bin/swaylock \
        --screenshots \
        --clock \
        --text-color cba6f7 \
        --text-ver-color cba6f7 \
        --text-clear-color cba6f7 \
        --text-wrong-color cba6f7 \
      	--indicator \
      	--indicator-radius 100 \
      	--indicator-thickness 7 \
      	--effect-blur 7x5 \
      	--effect-vignette 0.5:0.5 \
      	--ring-color 1e1e2e \
        --ring-ver-color 1e1e2e \
        --ring-clear-color cba6f7 \
        --ring-wrong-color f38ba8 \
        --bs-hl-color f38ba8 \
      	--key-hl-color cba6f7 \
      	--line-color 00000000 \
        --line-ver-color 00000000 \
        --line-clear-color 00000000 \
        --line-wrong-color 00000000 \
        --inside-color 00000088 \
        --inside-ver-color 00000088 \
        --inside-clear-color 00000088 \
        --inside-wrong-color 00000088 \
        --separator-color 00000000 \
      	--fade-in 0 \
        --timestr "%I:%M%p" \
        --datestr "%b %d, %Y" \
        --ignore-empty-password
    '';
  in ''
    {
      "label" : "lock",
      "action" : "${swaylock.outPath}",
      "text" : "󰌾",
      "keybind" : ""
    }
    {
      "label" : "logout",
      "action" : "loginctl terminate-user $USER",
      "text" : "󰗽",
      "keybind" : ""
    }
    {
      "label" : "shutdown",
      "action" : "systemctl poweroff",
      "text" : "󰐥",
      "keybind" : ""
    }
    {
      "label" : "reboot",
      "action" : "systemctl reboot",
      "text" : "󰑓",
      "keybind" : ""
    }
  '';
}
