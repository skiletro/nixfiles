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
        url = "https://w.wallhaven.cc/full/2y/wallhaven-2ymp5g.png";
        sha256 = "sha256-Vb1hu27QSXGO6JoQpkSP5OTrX1w2H4lwm3kx2Tbcgso=";
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
        terminal = 10;
      };
    };
  };
}
