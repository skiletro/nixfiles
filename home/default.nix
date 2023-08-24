{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Users
    ./jamie

    # Settings
    ./gtk

    # Window Managers
    ./hyprland

    # Programs
    ./fish
    ./starship
    ./anyrun
    #./kitty
    ./alacritty
    #./foot
    ./kanshi
    ./firefox
    ./neovim
    ./vscode
    ./eww
    ./wofi
    ./spicetify
    ./waybar
  ];

  nixpkgs.overlays = [
    inputs.nur.overlay
  ];

  home.packages = with pkgs; [
    # cli
    alejandra
    just
    direnv
    git
    gh
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

    #gui
    gnome.nautilus
    gtklock
    wlogout
    beeper
    obsidian
    networkmanagerapplet
    xorg.xeyes
    prismlauncher
    thunderbird
    dolphin-emu
    feh
    zotero
    libreoffice-qt
    hunspell #libreoffice
    hunspellDicts.en_GB-ise #libreoffice
    onlyoffice-bin #backup office
    obs-studio
    teams-for-linux
    vial
    libsForQt5.ark #zip
    pavucontrol
    vlc
    webcord-vencord
    gnome.gnome-font-viewer
    neovide

    # misc
    swayosd
    swaynotificationcenter
    udiskie
    gnome.adwaita-icon-theme
    catppuccin-gtk
    catppuccin-cursors
    xdg-utils
    libsForQt5.polkit-kde-agent

    # gaming
    lutris
    heroic #epic games & gog
    protonup-qt

    # temp
    rofi-wayland
    rofi-power-menu
  ];

  xdg = {
    enable = true;
    mimeApps.defaultApplications = {
      "inode/directory" = "nautilus.desktop";
      "application/pdf" = "firefox.desktop";
      "image/png" = "feh.desktop";
      "application/zip" = "ark.desktop";
      "text/css" = "nvim.desktop";
    };
  };

  fonts.fontconfig.enable = true;

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
