{
  lib,
  stdenv,
  appimageTools,
  fetchurl,
  writeTextDir,
  makeDesktopItem,
}: let
  beeper-desktop = makeDesktopItem rec {
    name = "beeper";
    exec = "beeper";
    icon = "beeper";
    comment = "beep beep";
    desktopName = "Beeper";
    genericName = "Beeper";
  };
in
  appimageTools.wrapType2 {
    name = "beeper";
    version = "3.71.16";

    src = fetchurl {
      url = "https://download.beeper.com/linux/appImage/x64";
      sha256 = "sha256-Ho5zFmhNzkOmzo/btV+qZfP2GGx5XvV/1JncEKlH4vc=";
    };

    extraPkgs = pkgs:
      with pkgs; [
        libsecret
      ];

    extraInstallCommands = ''
      mkdir -p $out/share/applications/
      ln -s ${beeper-desktop}/share/applications/* $out/share/applications
    '';
  }
