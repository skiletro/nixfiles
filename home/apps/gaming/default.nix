{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./prismlauncher
    ./mangohud
  ];

  home.packages = with pkgs; [
    # Tools
    gamescope #needed because hyprland is weird with gaming
    protonup-qt #modify steam proton versions

    # Launchers
    #dolphin-emu #wii and gamecube emulation - disabled due to compiler issues
    lutris #non-steam games that need extra tweaking
    #heroic #epic games & gog - disabled due to security (electron)
    (steam.override {
      #overrides needed primarily for gamescope to work w/ steam
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
}
