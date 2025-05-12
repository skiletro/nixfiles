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
      helix
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
    foot = {
      enable = true;
      package = w pkgs.foot;
    };
    waybar = {
      enable = true;
      package = w pkgs.waybar;
      settings.mainBar = {
        layer = "bottom";
        position = "bottom";
        modules-left = ["sway/workspaces" "sway/mode" "sway/window"];
        modules-center = [];
        modules-right = ["temperature" "clock" "tray"];
      };
    };

    lazygit.enable = true;
  };

  wayland.windowManager.sway = {
    enable = true;
    package = w pkgs.sway;
    checkConfig = true;
    config = {
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
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+f" = "flatpak run org.mozilla.firefox"; # Firefox comes default on SteamOS so we don't need to install it again.
          "${modifier}+Shift+f" = "fullscreen toggle";

          # For the Steam Deck action sets
          "F12+Shift+a" = config.wayland.windowManager.sway.config.menu;
          "F12+Shift+b" = "kill";
        };

      # Startup
      startup = [
        {command = "waybar";}
        {command = "${lib.getExe pkgs.autotiling-rs}";}
      ];

      bars = [];
    };

    extraConfig = ''
      default_border pixel 2px
    '';
  };
}
