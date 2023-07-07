{ lib, stdenv, appimageTools, fetchurl, writeTextDir }:

  appimageTools.wrapType2 {
    name = "beeper";
    version = "3.62.20";

    src = fetchurl {
        url = "https://download.beeper.com/linux/appImage/x64";
        sha256 = "5389e24ff3cef9acc6f137d24d37e9ef319c865ef81fa3337d407f927f087e31";
    };
    extraPkgs = pkgs: with pkgs; [
      libsecret
    ];

    #beeper-desktop = writeTextDir "share/applications/beeper.desktop" ''
    #  [Desktop Entry]
    #  Version=3.62.20
    #  Type=Application
    #  Name=Beeper
    #  Exec=beeper
    #'';
  }