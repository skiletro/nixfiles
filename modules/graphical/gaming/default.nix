{
  lib,
  pkgs,
  config,
  inputs,
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
      extraCompatPackages = [
        pkgs.proton-ge-bin # Proton Glorious Eggroll
        inputs.nix-gaming.packages.${pkgs.system}.northstar-proton
        inputs.nixpkgs-xr.packages.${pkgs.system}.proton-ge-rtsp-bin
      ];
      platformOptimizations.enable = true; # Handled by nix-gaming flake
    };

    environment.systemPackages =
      (with pkgs; [
        # Tools
        gamescope
        winetricks # Protontricks also used to be here, but it broke once I started declaring Proton packages declaratively.

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
      ])
      ++ [
        inputs.nix-gaming.packages.${pkgs.system}.viper # Titanfall 2 Northstar Client
      ];

    programs.gamemode = {
      enable = true;
      enableRenice = true;
    };

    services.flatpak.packages = [
      "sh.ppy.osu"
      {
        flatpakref = "https://sober.vinegarhq.org/sober.flatpakref";
        sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l";
      }
    ];
  };
}
