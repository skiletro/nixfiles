{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf (osConfig.eos.system.desktop == "plasma") {
    programs.plasma.shortcuts = {
      kwin = {
        "Overview" = "Meta,Meta+W,Toggle Overview";
        "Kill Window" = "Meta+Ctrl+Esc";

        # Workspace Binds
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+\"";
        "Window to Desktop 3" = "Meta+£";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";

        # Window Manipulation
        "Window Close" = ["Alt+F4" "Meta+Shift+Q"];
        "Window Maximize" = "Meta+Up";
        "Window Quick Tile Bottom" = "Meta+Down";
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
      };

      plasmashell = {
        "show dashboard" = "Meta+Shift+D";
      };

      # Media
      mediacontrol = {
        "nextmedia" = "Media Next";
        "pausemedia" = "Media Pause";
        "playmedia" = "none,,Play media playback";
        "playpausemedia" = "Media Play";
        "previousmedia" = "Media Previous";
        "stopmedia" = "Media Stop";
        # Keyboard (Sofle) Volume Wheel for Spotify
        "mediavolumedown" = "F19,,Media volume down";
        "mediavolumeup" = "F18,,Media volume up";
      };

      # Program Shortcuts
      "services/net.local.flameshot.desktop"."_launch" = "Meta+Shift+S";
      "services/org.kde.kcalc.desktop"."_launch" = ["Calculator" "Meta+C"];
      "services/org.kde.konsole.desktop"."_launch" = "Meta+Return";
      "services/org.kde.krunner.desktop"."_launch" = ["Meta+D" "Search"];
      "services/org.kde.spectacle.desktop"."_launch" = "Print";
      "services/zen.desktop"."_launch" = "Meta+F";
    };
  };
}
