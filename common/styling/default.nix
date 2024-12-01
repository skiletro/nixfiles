{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  stylix = {
    enable = true;

    # Color scheme
    base16Scheme = ./quixayu.yaml;

    # Wallpaper
    image = let
      input = pkgs.fetchurl {
        #url = "https://i.imgur.com/b0H66vt.jpeg";
        #sha256 = "sha256-BhYzihD72Zpf4Rjds+b5gWweSl2NAMeRcLADLF4rsWs=";
        url = "https://w.wallhaven.cc/full/d6/wallhaven-d6y12l.jpg";
        sha256 = "sha256-eMfcl2bPqHTP6KiWt9CHuysQs+3ZEsZlNgAYz/vS0/Y=";
      };
    in
      pkgs.runCommand "output.png" {} ''
        ${pkgs.lutgen}/bin/lutgen apply ${input} -o $out -- ${builtins.concatStringsSep " " (with config.lib.stylix.colors; [
          base00
          base01
          base02
          base03
          base04
          base05
          base06
          base07
          base08
          base09
          base0A
          base0B
          base0C
          base0D
          base0E
          base0F
        ])}
      ''; # FIXME: Could be simplified

    # Cursors
    cursor = {
      package = inputs.cursors.packages.${pkgs.system}.apple-cursor.override {
        background_color = "#${config.lib.stylix.colors.base00}";
        outline_color = "#${config.lib.stylix.colors.base06}";
        accent_color = "#${config.lib.stylix.colors.base00}";
      };
      name = "Apple-Custom";
      size = 24;
    };

    # Fonts
    fonts = {
      sansSerif = {
        package = pkgs.nerd-fonts.mplus;
        name = "M+2 Nerd Font";
      };
      serif = config.stylix.fonts.sansSerif; # Set serif font to the same as the sans-serif
      monospace = {
        package = pkgs.nerd-fonts.mplus;
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
        terminal = 10;
      };
    };
  };
}
