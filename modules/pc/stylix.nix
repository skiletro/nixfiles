{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  stylix = {
    enable = true;

    # Color scheme
    base16Scheme = ./everblush.yaml;

    # Wallpaper
    image = let
      input = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/vp/wallhaven-vpx8ep.jpg";
        sha256 = "1rv464kh4dn2dgwzf4411r6l6hlkx36y2vsb28x890pj86917vcb";
      };
    in
      pkgs.runCommand "output.png" {} "${lib.getExe pkgs.lutgen} apply ${input} -o $out -- ${builtins.concatStringsSep " " config.lib.stylix.colors.toList}";

    # Cursors
    cursor = {
      package = with config.lib.stylix.colors;
        inputs.cursors.packages.${pkgs.system}.breeze-cursor.override {
          background_color = "#${base00}";
          outline_color = "#${base06}";
          accent_color = "#${base00}";
        };
      name = "Breeze-Custom";
      size = 24;
    };

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
}
