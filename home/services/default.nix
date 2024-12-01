{pkgs, ...}: {
  imports = [
    ./direnv
    ./eww
    ./fish
    ./rofi
    ./starship
    ./swaync
    ./syncthing
    ./wlogout
    ./swaylock
  ];

  home.packages = with pkgs; [
    wlsunset
    xdg-utils
    libsForQt5.polkit-kde-agent
    networkmanagerapplet
    wineWowPackages.stable #wine
    winetricks #wine
    playerctl
    brightnessctl
    pamixer
    upower
    sway-contrib.grimshot #screenshots
    wtype
    htop
    wget
    unzip
    unrar
    jq
    socat
    ripgrep
    btop
    libnotify
    glib
    acpi
    wl-clipboard
    fzf
    lutgen
    cmake
    gnumake
    fd
    imagemagick
    just
    du-dust
    tldr
    tmux
  ];
}
