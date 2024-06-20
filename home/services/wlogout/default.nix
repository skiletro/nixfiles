{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.windowManager.hyprland.enable {
    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "swaylock";
          text = "󰌾";
          keybind = "";
        }
        {
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "󰗽";
          keybind = "";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "󰐥";
          keybind = "";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "󰑓";
          keybind = "";
        }
      ];
      style = ''
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
    };
  };
}
