{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
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

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
    # Fonts
    fonts = {
      sansSerif = {
        package = pkgs.nerd-fonts."m+";
        name = "M+2 Nerd Font";
      };
      serif = config.stylix.fonts.sansSerif; # Set serif font to the same as the sans-serif
      monospace = {
        package = pkgs.nerd-fonts."m+";
        name = "M+1Code Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
  };

  home.packages = with pkgs; [
    just
    helix
    fastfetch
    nixd
  ];

  programs = {
    foot = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.foot;
    };
    waybar = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.waybar;
    };

    lazygit.enable = true;
  };

  wayland.windowManager.sway = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.sway;
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
      input."*".xkb_layout = "gb";

      # Keybindings
      menu = "${lib.getExe pkgs.wofi} --show drun";
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+f" = "flatpak run org.mozilla.firefox"; # Firefox comes default on SteamOS so we don't need to install it again.
          "${modifier}+Shift+f" = "fullscreen toggle";
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
