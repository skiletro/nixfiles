{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./scaling.nix
  ];

  config = lib.mkIf osConfig.customConfig.windowManager.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        exec-once = [
          "eww open bar"
          "swaync &" #notifications
          "diskie &" #auto-mounting of external storage
          "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &" #keyring
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" #fixes apps taking forever to launch

          "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1" #for stuff like passwords
          "swww init;sleep 1;swww img $HOME/.bg.png"
        ];

        general = {
          gaps_in = 3;
          gaps_out = 5;
          border_size = 2;
          "col.active_border" = "0xffcba6f7"; #mauve
          "col.inactive_border" = "0xff11111b"; #crust
          layout = "dwindle";
        };

        dwindle = {
          special_scale_factor = 0.975;
          pseudotile = true;
          preserve_split = true;
        };

        master.new_is_master = true;

        input = {
          kb_layout = "gb";
          follow_mouse = 1;
          touchpad.natural_scroll = "no";
          sensitivity = 0;
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_forever = false;
        };

        decoration = {
          rounding = 5;
          drop_shadow = false;
          dim_special = 0.4;
          blur = {
            enabled = true;
            passes = 2;
            noise = 0.05;
            special = false;
            new_optimizations = 1;
          };
        };

        animations = {
          enabled = true;

          bezier = [
            "smoothed, 0.05, 0.9, 0.1, 1"
          ];

          animation = [
            "windows, 1, 5, smoothed"
            "windowsIn, 1, 5, smoothed, slide"
            "windowsOut, 1, 5, default, popin 80%"

            "border, 1, 5, default"
            "fade, 1, 7, default"
            "workspaces, 1, 3, smoothed"
            "specialWorkspace, 1, 3, smoothed, slidevert"
          ];
        };

        windowrule = [
          "float, ^(org.kde.polkit-kde-authentication-agent-1)$"
        ];

        windowrulev2 = [
          "suppressevent maximize, class:.*" # Stops windows from maximising (looking at you, libreoffice)

          # Fixes https://github.com/hyprwm/Hyprland/issues/2661#issuecomment-1848940324
          "stayfocused, title:^()$,class:^(steam)$"
          "minsize 1 1, title:^()$,class:^(steam)$"

          # Sets popups relating to bar/shell
          "float, class:^(gamescope)$,fullscreen:1"
          "float, title:^(nmtui-popup)$"
          "float, title:^(btop-popup)$"
          "float, title:^(onedrive-popup)$"
          "float, class:^(pavucontrol)$"
          "float, class:^(nm-connection-editor)$"
          "float, class:^(.blueman-manager-wrapped)$"
        ];

        bind = let
          window_kill_script = pkgs.writeShellScript "window_kill_script" ''
            if [ "$(hyprctl activewindow -j | jq -r ".class")" = "Steam" ]; then
              ${pkgs.xdotool}/bin/xdotool getactivewindow windowunmap
            else
              hyprctl dispatch killactive ""
            fi
          '';
        in [
          # General
          "SUPER SHIFT, Q, exec, ${window_kill_script.outPath}"
          "SUPER SHIFT, SPACE, togglefloating, "
          "CTRL SUPER ALT, SPACE, fullscreen, 0"
          "SUPER, J, togglesplit," #dwindle

          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          "SUPER CTRL, left, resizeactive, -20 0"
          "SUPER CTRL, right, resizeactive, 20 0"
          "SUPER CTRL, up, resizeactive, 0 -20"
          "SUPER CTRL, down, resizeactive, 0 20"

          "SUPER SHIFT, left, movewindow, l"
          "SUPER SHIFT, right, movewindow, r"
          "SUPER SHIFT, up, movewindow, u"
          "SUPER SHIFT, down, movewindow, d"

          "SUPER, grave, togglespecialworkspace" #scratchpad
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          "SUPER SHIFT, grave, movetoworkspace, special" #scratchpad
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"

          "SUPER, mouse_down, workspace, e+1"
          "SUPER, mouse_up, workspace, e-1"

          # Launch Programs
          "SUPER, D, exec, rofi -show drun"
          "SUPER SHIFT, E, exec, wlogout -b 1 -p layer-shell"
          '', Print, exec, grimshot copy screen && notify-send "Captured!" "Screenshot (fullscreen) copied to clipboard." # Screenshot''
          ''SHIFT, Print, exec, grimshot copy area && notify-send "Captured!" "Screenshot (area) copied to clipboard." # Screenshot''
          ''SUPER SHIFT, S, exec, grimshot copy area && notify-send "Screenshot (area) copied to clipboard". # Screenshot for when at pc :)''
          "SUPER, Home, exec, swaync-client -t"
          ''SUPER, period, exec, rofimoji -r "󰞅" --selector-args " -no-show-icons"''

          "SUPER, RETURN, exec, alacritty"
          "SUPER, E, exec, nautilus -w"
          "SUPER, F, exec, firefox"
          "SUPER, N, exec, emacs ~/.nix_config"

          # Media Keys
          ", XF86MonBrightnessUp, exec, bash ~/.config/eww/launchers/set-brightness up"
          ", XF86MonBrightnessDown, exec, bash ~/.config/eww/launchers/set-brightness down"
          ", XF86AudioRaiseVolume, exec, bash ~/.config/eww/launchers/set-volume up"
          ", XF86AudioLowerVolume, exec, bash ~/.config/eww/launchers/set-volume down"
          ", XF86AudioMute, exec, bash ~/.config/eww/launchers/set-volume mute"
          ", XF86AudioPlay, exec, playerctl --player=spotify,%any play-pause"
          ", XF86AudioNext, exec, playerctl --player=spotify,%any next"
          ", XF86AudioPrev, exec, playerctl --player=spotify,%any previous"
        ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        bindl = [
          ",switch:Lid Switch, exec, swaylock"
        ];

        xwayland = {
          use_nearest_neighbor = false;
          force_zero_scaling = true;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          vfr = true;
        };

        env = [
          "GTK_THEME, Catppuccin-Mocha-Standard-Mauve-Dark"
          "QT_QPA_PLATFORMTHEME, gtk2"
          "XCURSOR_THEME, Catppuccin-Mocha-Dark-Cursors"

          "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"

          "GDK_BACKEND, wayland,x11"
          "QT_QPA_PLATFORM, xcb"
          "CLUTTER_BACKEND, wayland"

          "XDG_CURRENT_DESKTOP, Hyprland"
          "XDG_SESSION_TYPE, wayland"
          "XDG_SESSION_DESKTOP, Hyprland"

          "ENABLE_VKBASALT, 1"
        ];
      };

      extraConfig = ''
        # Per device configuration for PRO X SUPERLIGHT
        device {
          name = logitech-usb-receiver
          accel_profile = flat
          sensitivity = 0.3
        }
      '';
    };
  };
}
