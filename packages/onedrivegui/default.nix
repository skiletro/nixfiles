{ lib, stdenv, appimageTools, fetchurl, writeTextDir, makeDesktopItem }:

  let 
    onedrivegui-desktop = makeDesktopItem rec {
      name = "OneDriveGUI";
      exec = "OneDriveGUI";
      icon = "onedrivegui";
      comment = "lil app icon tray";
      desktopName = "OneDriveGUI";
      genericName = "OneDriveGUI";
    };
  in appimageTools.wrapType2 {
    name = "onedrivegui";
    version = "1.0.2";

    src = fetchurl {
        url = "https://github.com/bpozdena/OneDriveGUI/releases/download/v1.0.2/OneDriveGUI-1.0.2-x86_64.AppImage";
        sha256 = "sha256-shptKaPscCN5UApaMhYX8jDdkGcCZ1KSS7RtnearS9A=";
    };

    extraPkgs = pkgs: with pkgs; [
      python311
      python311Packages.pyside6
      python311Packages.pyqtwebengine
      python311Packages.requests
    ];

    extraInstallCommands = ''
      mkdir -p $out/share/applications/
      ln -s ${onedrivegui-desktop}/share/applications/* $out/share/applications
    '';
  }
