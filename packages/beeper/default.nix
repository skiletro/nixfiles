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
        sha256 = "sha256-gUuxExz1+xUKtsZQss5Uuf4+JjWerP061qcJY+3jeco=";
    };

    extraPkgs = pkgs: with pkgs; [
      libsecret
    ];

    extraInstallCommands = ''
      mkdir -p $out/share/applications/
      ln -s ${beeper-desktop}/share/applications/* $out/share/applications
    '';
  }
