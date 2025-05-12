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
      menu = "${lib.getExe pkgs.wofi} --show drun";
      keybindings = let
        m = config.wayland.windowManager.sway.config.modifier;
        sd = "F12+Shift";
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

      bars = [];
    };

    extraConfig = ''
      default_border pixel 2px
    '';
  };
}
