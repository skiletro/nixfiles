{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf (osConfig.userConfig.desktop.terminalEmulator == "konsole") {
    home.packages = with pkgs; [konsole];

    xdg.dataFile."konsole/Stylix.profile".text = lib.generators.toINI {} {
      General = {
        Name = "Stylix";
        Parent = "FALLBACK/";
        TerminalCenter = false;
        TerminalMargin = 4;
      };

      Appearance = {
        AntiAliasFonts = true;
        ColorScheme = "Stylix";
      };

      "Cursor Options".CursorShape = 1;
      "Terminal Features".BlinkingCursorEnabled = true;
    };

    xdg.dataFile."konsole/Stylix.colorscheme".text = with osConfig.lib.stylix.colors; let
      fmt = r: g: b: "${r}, ${g}, ${b}";

      foreground = fmt base05-rgb-r base05-rgb-g base05-rgb-b;
      background = fmt base00-rgb-r base00-rgb-g base00-rgb-b;
      background-lighter = fmt base03-rgb-r base03-rgb-g base03-rgb-b;

      red = fmt base08-rgb-r base08-rgb-g base08-rgb-b;
      green = fmt base0B-rgb-r base0B-rgb-g base0B-rgb-b;
      yellow = fmt base0A-rgb-r base0A-rgb-g base0A-rgb-b;
      blue = fmt base0D-rgb-r base0D-rgb-g base0D-rgb-b;
      purple = fmt base0E-rgb-r base0E-rgb-g base0D-rgb-b;
      cyan = fmt base0C-rgb-r base0C-rgb-g base0C-rgb-b;
    in
      lib.generators.toINI {} {
        Background.Color = background;
        BackgroundFaint.Color = background;
        BackgroundIntense.Color = background-lighter;

        Color0.Color = background;
        Color0Faint.Color = background;
        Color0Intense.Color = background-lighter;

        Color1.Color = red;
        Color1Faint.Color = red;
        Color1Intense.Color = red;

        Color2.Color = green;
        Color2Faint.Color = green;
        Color2Intense.Color = green;

        Color3.Color = yellow;
        Color3Faint.Color = yellow;
        Color3Intense.Color = yellow;

        Color4.Color = blue;
        Color4Faint.Color = blue;
        Color4Intense.Color = blue;

        Color5.Color = purple;
        Color5Faint.Color = purple;
        Color5Intense.Color = purple;

        Color6.Color = cyan;
        Color6Faint.Color = cyan;
        Color6Intense.Color = cyan;

        Color7.Color = foreground;
        Color7Faint.Color = foreground;
        Color7Intense.Color = foreground;
        Foreground.Color = foreground;
        ForegroundFaint.Color = foreground;
        ForegroundIntense.Color = foreground;

        General = {
          Anchor = "0.5,0.5";
          Blur = false;
          ColorRandomization = false;
          Description = "Stylix";
          FillStyle = "Tile";
          Opacity = 1;
          Wallpaper = "";
          WallpaperFlipType = "NoFlip";
          WallpaperOpacity = 1;
        };
      };
  };
}
