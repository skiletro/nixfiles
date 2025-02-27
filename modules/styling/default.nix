{
  pkgs,
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
        url = "https://w.wallhaven.cc/full/2y/wallhaven-2yrml9.png";
        sha256 = "1aj8w1cv148bjbasf7nb19myn7ksmipawv4w7x3qlnrrj6xgigvc";
      };
    in
      pkgs.runCommand "output.png" {} "${pkgs.lutgen}/bin/lutgen apply ${input} -o $out -- ${builtins.concatStringsSep " " config.lib.stylix.colors.toList}";

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
        terminal = 12;
      };
    };
  };
}
