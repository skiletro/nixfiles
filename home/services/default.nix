{pkgs, ...}: {
  imports = [
    ./eww
    ./swaync
    ./wlogout
  ];

  home.packages = with pkgs; [
    swaynotificationcenter
    udiskie
    xdg-utils
    libsForQt5.polkit-kde-agent
    networkmanagerapplet
    wineWowPackages.stable #wine
    winetricks #wine
    hunspell
    hunspellDicts.en_GB-ise
  ];
}
