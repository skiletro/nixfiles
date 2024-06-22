{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.graphical.gaming.steam.enable {
    home.packages = with pkgs; [
      (steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            libgdiplus
            keyutils
            libkrb5
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            at-spi2-atk
            fmodex
            gtk3
            gtk3-x11
            harfbuzz
            icu
            glxinfo
            inetutils
            libthai
            mono5
            pango
            strace
            zlib
            libunwind # for tf|2 northstar launcher
          ];
      })
    ];
  };
}
