{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf (osConfig.userConfig.desktop.terminalEmulator == "konsole") {
    home.packages = with pkgs; [konsole];

    # TODO: There *must* be a better way of doing this... this is horrendous...
    xdg.dataFile."konsole/Stylix.colorscheme".text = with osConfig.lib.stylix.colors; ''
      [Background]
      Color=${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}

      [BackgroundFaint]
      Color=${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}

      [BackgroundIntense]
      Color=${base03-rgb-r}, ${base03-rgb-g}, ${base03-rgb-b}

      [Color0]
      Color=${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}

      [Color0Faint]
      Color=${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}

      [Color0Intense]
      Color=${base03-rgb-r}, ${base03-rgb-g}, ${base03-rgb-b}

      [Color1]
      Color=${base08-rgb-r}, ${base08-rgb-g}, ${base08-rgb-b}

      [Color1Faint]
      Color=${base08-rgb-r}, ${base08-rgb-g}, ${base08-rgb-b}

      [Color1Intense]
      Color=${base08-rgb-r}, ${base08-rgb-g}, ${base08-rgb-b}

      [Color2]
      Color=${base0B-rgb-r}, ${base0B-rgb-g}, ${base0B-rgb-b}

      [Color2Faint]
      Color=${base0B-rgb-r}, ${base0B-rgb-g}, ${base0B-rgb-b}

      [Color2Intense]
      Color=${base0B-rgb-r}, ${base0B-rgb-g}, ${base0B-rgb-b}

      [Color3]
      Color=${base0A-rgb-r}, ${base0A-rgb-g}, ${base0A-rgb-b}

      [Color3Faint]
      Color=${base0A-rgb-r}, ${base0A-rgb-g}, ${base0A-rgb-b}

      [Color3Intense]
      Color=${base0A-rgb-r}, ${base0A-rgb-g}, ${base0A-rgb-b}

      [Color4]
      Color=${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b}

      [Color4Faint]
      Color=${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b}

      [Color4Intense]
      Color=${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b}

      [Color5]
      Color=${base0E-rgb-r}, ${base0E-rgb-g}, ${base0E-rgb-b}

      [Color5Faint]
      Color=${base0E-rgb-r}, ${base0E-rgb-g}, ${base0E-rgb-b}

      [Color5Intense]
      Color=${base0E-rgb-r}, ${base0E-rgb-g}, ${base0E-rgb-b}

      [Color6]
      Color=${base0C-rgb-r}, ${base0C-rgb-g}, ${base0C-rgb-b}

      [Color6Faint]
      Color=${base0C-rgb-r}, ${base0C-rgb-g}, ${base0C-rgb-b}

      [Color6Intense]
      Color=${base0C-rgb-r}, ${base0C-rgb-g}, ${base0C-rgb-b}

      [Color7]
      Color=${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}

      [Color7Faint]
      Color=${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}

      [Color7Intense]
      Color=${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}

      [Foreground]
      Color=${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}

      [ForegroundFaint]
      Color=${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}

      [ForegroundIntense]
      Color=${base05-rgb-r}, ${base05-rgb-g}, ${base05-rgb-b}

      [General]
      Anchor=0.5,0.5
      Blur=false
      ColorRandomization=false
      Description=Stylix
      FillStyle=Tile
      Opacity=1
      Wallpaper=
      WallpaperFlipType=NoFlip
      WallpaperOpacity=1
    '';
  };
}
