{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Users
    ./jamie

    # Settings
    ./theme
    ./kanshi #monitor matching

    # Window Managers
    ./hyprland
    ./sway

    # Programs
    ./fish
    ./starship
    #./foot
    #./kitty
    ./alacritty
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
  ];

  nixpkgs.overlays = [
    inputs.nur.overlay
  ];

  home.packages = with pkgs; [
    # cli
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

    #gui
    gnome.nautilus
    gtklock
    wlogout
    beeper
    obsidian
    networkmanagerapplet
    xorg.xeyes
    thunderbird
    nomacs
    zotero
    libreoffice-qt
    hunspell #libreoffice
    hunspellDicts.en_GB-ise #libreoffice
    obs-studio
    teams-for-linux
    vial
    gnome.file-roller #zip
    pavucontrol
    vlc
    webcord-vencord
    gnome.gnome-font-viewer
    neovide
    inkscape

    # lsp
    rust-analyzer
    nodePackages.bash-language-server #sh and bash
    zls #zig
    rnix-lsp #nix

    # misc
    swaynotificationcenter
    udiskie
    gnome.adwaita-icon-theme
    catppuccin-gtk
    catppuccin-cursors
    xdg-utils
    libsForQt5.polkit-kde-agent

    # gaming
    prismlauncher
    dolphin-emu
    lutris
    heroic #epic games & gog
    protonup-qt
    mangohud

    # temp
    rofimoji
    catimg
  ];

  xdg = {
    enable = true;
    mimeApps.defaultApplications = {
      "inode/directory" = "nautilus.desktop";
      "application/pdf" = "firefox.desktop";
      "image/png" = "nomacs.desktop";
      "application/zip" = "file-roller.desktop";
      "text/css" = "nvim.desktop";
    };
  };

  fonts.fontconfig.enable = true;

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
