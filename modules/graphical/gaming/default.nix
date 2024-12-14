{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./emulators.nix
    ./vr.nix
  ];

  options.userConfig.gaming.enable = lib.mkEnableOption "Game Launchers: Steam, Heroic, etc.";

  config = lib.mkIf config.userConfig.gaming.enable {
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
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
      };
      gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # Tools
      gamescope
      protonup-qt # Modify Steam Proton versions

      # Launchers
      lutris # Games that need extra configuration
      bottles # Same idea as Lutris, but has support for regular software too
      heroic # Epic Games, Gog, and Amazon Prime Gaming
      r2modman # Thunderstore Mod Manager (Think Lethal Company, derivationStrict)
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

    services.flatpak.packages = [
      "sh.ppy.osu"
    ];
  };
}
