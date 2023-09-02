{
  appimageTools,
  fetchurl,
  makeDesktopItem,
}: let
  pname = "beeper";
  version = "3.71.16";
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://drive.usercontent.google.com/download?id=1zt__HvjKGxV6aUbV21fopfqrVffmpghL&export=download&authuser=0&confirm=t&uuid=95f6e06b-ab85-4f91-ace1-e2586f58ad86&at=APZUnTUEGxrCu5CfBrz74eA7uI2g:1692880446732";
    sha256 = "sha256-Ho5zFmhNzkOmzo/btV+qZfP2GGx5XvV/1JncEKlH4vc=";
  };
  desktop-file = makeDesktopItem rec {
    name = "Beeper";
    exec = "beeper";
    icon = "beeper";
    comment = "Unified Desktop";
    desktopName = "Beeper";
    genericName = "Beeper";
  };
  appimageContents = appimageTools.extractType2 {inherit name src;};
in
  appimageTools.wrapType2 {
    inherit name src;

    extraPkgs = pkgs:
      with pkgs; [
        libsecret
      ];

    extraInstallCommands = ''
      mv $out/bin/${name} $out/bin/${pname}

      mkdir -p $out/share/applications/
      ln -s ${desktop-file}/share/applications/* $out/share/applications

      install -m 444 -D ${appimageContents}/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png

    '';
  }
