{pkgs, ...}: {
  imports = [
    ./eww
    ./swaync
    ./syncthing
    ./wlogout
    ./swaylock
  ];

  home.packages = with pkgs; [
    swaynotificationcenter
    udiskie
    xdg-utils
    libsForQt5.polkit-kde-agent
    networkmanagerapplet
    wineWowPackages.stable #wine
    winetricks #wine
  ];
}
