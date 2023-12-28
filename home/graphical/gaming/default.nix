{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./mangohud
    ./prismlauncher
    ./steam
  ];

  home.packages = with pkgs; [
    # Tools
    gamescope #needed because hyprland is weird with gaming
    protonup-qt #modify steam proton versions
    parsec-bin

    # Launchers
    #dolphin-emu #wii and gamecube emulation - disabled due to compiler issues
    lutris #non-steam games that need extra tweaking
    #heroic #epic games & gog - disabled due to security (electron)
  ];
}
