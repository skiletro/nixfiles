{pkgs, ...}: {
  imports = [
    ./eww
    ./rofi
    ./swaync
    ./syncthing
    ./wlogout
    ./swaylock
  ];

  home.packages = with pkgs; [
    onedrive
    wlsunset
    xdg-utils
    libsForQt5.polkit-kde-agent
    networkmanagerapplet
    wineWowPackages.stable #wine
    winetricks #wine
  ];
}
