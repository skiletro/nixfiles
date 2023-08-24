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
      url = "https://drive.usercontent.google.com/download?id=1zt__HvjKGxV6aUbV21fopfqrVffmpghL&export=download&authuser=0&confirm=t&uuid=95f6e06b-ab85-4f91-ace1-e2586f58ad86&at=APZUnTUEGxrCu5CfBrz74eA7uI2g:1692880446732";
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
