{ lib, stdenv, appimageTools, fetchurl, writeTextDir, makeDesktopItem }:

  let 
    beeper-desktop = makeDesktopItem rec {
      name = "beeper";
      exec = "beeper";
      icon = "beeper";
      comment = "beep beep";
      desktopName = "Beeper";
      genericName = "Beeper";
    };
  in appimageTools.wrapType2 {
    name = "beeper";
    version = "3.62.20";

    src = fetchurl {
        url = "https://download.beeper.com/linux/appImage/x64";
        sha256 = "5389e24ff3cef9acc6f137d24d37e9ef319c865ef81fa3337d407f927f087e31";
    };

    extraPkgs = pkgs: with pkgs; [
      libsecret
    ];

    extraInstallCommands = ''
      mkdir -p $out/share/applications/
      ln -s ${beeper-desktop}/share/applications/* $out/share/applications
    '';
  }