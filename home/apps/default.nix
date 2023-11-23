{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./fish
    ./starship
    #./foot
    #./kitty
    ./alacritty
    #./wezterm
    ./emacs
    ./firefox
    ./neovim
    ./vscode
    ./eww
    ./rofi
    ./spicetify
    ./btop
    ./wlogout
    ./zathura
    ./swaync
    ./zellij
    ./bat
    ./kanshi #monitor matching
    ./gaming
  ];

  home.packages = with pkgs; [
    # CLI Tools
    inputs.nh.packages.${pkgs.system}.default
    wget
    unzip
    unrar
    jq
    socat
    ripgrep
    neofetch
    swww
    htop
    btop #better htop but is a bit more cluttered
    tmux
    onedrive
    playerctl
    brightnessctl
    pamixer
    libnotify
    glib
    upower
    acpi
    wlsunset
    cava
    sway-contrib.grimshot #screenshots
    wl-clipboard
    wtype
    fzf
    python311
    nodejs_18
    nix-index
    nix-prefetch
    wineWowPackages.stable #wine
    winetricks #wine
    distrobox
    podman
    lutgen
    cmake
    gnumake
    fd
    imagemagick

    # GUI Programs
    gnome.nautilus
    gtklock
    wlogout
    beeper
    #obsidian - disabled due to security (electron)
    networkmanagerapplet
    xorg.xeyes
    thunderbird
    nomacs
    #zotero - disabled due to security
    libreoffice-qt
    hunspell #libreoffice
    hunspellDicts.en_GB-ise #libreoffice
    obs-studio
    #teams-for-linux - disabled due to security (electron)
    vial
    gnome.file-roller #gui zip tool
    pavucontrol
    vlc
    webcord
    gnome.gnome-font-viewer
    neovide
    inkscape
    qdirstat

    # Misc (Mostly stuff to complement the compositor)
    swaynotificationcenter
    udiskie
    gnome.adwaita-icon-theme
    catppuccin-gtk
    catppuccin-cursors
    xdg-utils
    libsForQt5.polkit-kde-agent
    fusee-interfacee-tk #switch rcm

    # Programs being used as part of my university course
    rstudio
  ];
}
