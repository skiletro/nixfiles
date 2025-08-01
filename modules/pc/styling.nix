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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # Wallpaper
    image = let
      input = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/13/wallhaven-13reow.png";
        sha256 = "1lns86p10wqnnx4h3lcr08p323c7s5n5mkzgz941anm21gja1ngh";
      };
    in
      pkgs.runCommand "output.png" {} "${lib.getExe pkgs.lutgen} apply ${input} -o $out -- ${builtins.concatStringsSep " " config.lib.stylix.colors.toList}";

    # Cursors
    cursor = {
      package = with config.lib.stylix.colors.withHashtag;
        inputs.cursors.packages.${pkgs.system}.bibata-modern-cursor.override {
          background_color = base00;
          outline_color = base06;
          accent_color = base00;
        };
      name = "Bibata-Modern-Custom";
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
