{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  w = config.lib.nixGL.wrap;
in {
  imports = [../../modules/styling];

  stylix.cursor.size = lib.mkForce 20; # Make the cursor a bit smaller

  home = {
    username = "deck";
    homeDirectory = "/home/deck";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  nixGL = {
    packages = import inputs.nixgl {inherit pkgs;};
    defaultWrapper = "mesa";
    installScripts = ["mesa"];
  };

  home.packages =
    (with pkgs; [
      just
      fastfetch
      nixd
    ])
    ++ [
      (pkgs.writeShellScriptBin "start_sway" ''
        #!/bin/sh
        unset LD_PRELOAD
        source /etc/profile.d/nix.sh
        exec sway # We wrap it below, so we don't need to run it under nixGL here.
      '')
    ];

  programs = {
    alacritty = {
      enable = true;
      package = w pkgs.alacritty;
    };
    waybar = {
      enable = true;
      package = w pkgs.waybar;
      settings.mainBar = {
        layer = "bottom";
        position = "bottom";
        modules-left = ["sway/workspaces" "sway/mode" "sway/window"];
        modules-center = [];
        modules-right = ["temperature" "battery" "clock" "tray"];
      };
    };
    anyrun = {
      enable = true;
      package = w pkgs.anyrun;
      config.closeOnClick = true;
    };
    helix = {
      enable = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
    };
    lazygit = {
      enable = true;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    package = w pkgs.sway;
    checkConfig = true;
    config = {
      terminal = "${lib.getExe pkgs.alacritty}";
      modifier = "Mod4";
      defaultWorkspace = "workspace number 1";

      # Output
      output.X11-1 = {
        mode = "1280x800";
        scale = "1.25";
      };

      # Input
      input."*" = {
        xkb_layout = "gb";
        xkb_options = "caps:ctrl_modifier";
      };

      # Keybindings
      menu = "${lib.getExe pkgs.anyrun}";
      keybindings = let
        m = config.wayland.windowManager.sway.config.modifier;
        sd = "Mod2"; # Num Lock
      in
        lib.mkOptionDefault {
          "${m}+f" = "exec flatpak run org.mozilla.firefox"; # Firefox comes default on SteamOS so we don't need to install it again.
          "${m}+Shift+f" = "fullscreen toggle";

          # For Steam Deck action sets
          "${sd}+a" = "exec ${config.wayland.windowManager.sway.config.menu}";
          "${sd}+b" = "kill";
          "${sd}+c" = "exec ${lib.getExe pkgs.xfce.thunar}";
          "${sd}+d" = "exec ${config.wayland.windowManager.sway.config.terminal}";
          "${sd}+e" = "exec flatpak run org.mozilla.firefox";

          "${sd}+1" = "workspace number 1";
          "${sd}+2" = "workspace number 2";
          "${sd}+3" = "workspace number 3";
          "${sd}+4" = "workspace number 4";
          "${sd}+5" = "workspace number 5";
          "${sd}+6" = "workspace number 6";
        };

      # Startup
      startup = [
        {command = "waybar";}
        {command = "${lib.getExe pkgs.autotiling-rs}";}
        {command = "${lib.getExe pkgs.dunst}";}
      ];

      # Remove swaybar, we're using waybar instead.
      bars = [];
    };

    extraSessionCommands = ''
      export WLR_DRM_NO_MODIFIERS=1 # Test fix for external monitor being black
      export MOZ_ENABLE_WAYLAND=1 # Use native wayland renderer for Firefox
      export QT_QPA_PLATFORM=wayland # Use native wayland renderer for QT applications
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1 # Allow sway to manage window decorations
      export SDL_VIDEODRIVER=wayland # Use native wayland renderer for SDL applications
      export XDG_SESSION_TYPE=wayland # Let XDG-compliant apps know they're working on wayland
      export _JAVA_AWT_WM_NONREPARENTING=1 # Fix JAVA drawing issues in sway
      source "${pkgs.nix}/etc/profile.d/nix.sh" # Let sway have access to your nix profile
      # https://github.com/dmayle/nix-config/blob/7af94813eb5c6f4d956dcda7df24a6434d092cb9/home-profiles/nixgl-sway.nix#
    '';

    extraConfig = ''
      default_border pixel 2px
    '';
  };
}
