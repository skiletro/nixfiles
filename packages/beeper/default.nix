{ lib, stdenv, pkgs }:

  beeper = super.appimageTools.wrapType2 {
    name = "beeper";
    version = "3.62.20";

    src = super.fetchurl {
        url = "https://download.beeper.com/linux/appImage/x64";
        hash = "5389e24ff3cef9acc6f137d24d37e9ef319c865ef81fa3337d407f927f087e31";
    };

    beeer-desktop = super.writeTextDir "share/applications/beeper.desktop" ''
      [Desktop Entry]
      Version=3.62.20
      Type=Application
      Name=Beeper
      Exec=beeper
    '';
  }