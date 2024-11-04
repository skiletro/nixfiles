{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.gaming.launchers.enable {
    programs.mangohud = {
      enable = true;
      enableSessionWide = false; # Need to test to see if it crashes gamescope with workaround implem.
    };

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
      (prismlauncher.override {
        # Java Versions. Minecraft needs 8, 11, 17, and 21 as of 2024-10-25.
        jdks = with pkgs; [
          temurin-jre-bin-8
          temurin-jre-bin-11
          temurin-jre-bin-17
          temurin-jre-bin-21
        ];
      })
    ];
  };
}
