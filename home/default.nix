{ config, pkgs, lib, inputs, ... }:

{

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
    ./kitty #disabled
    ./alacritty
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
    swaybg
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
    xfce.thunar
    gtklock
    beeper
    obsidian
    networkmanagerapplet
    xorg.xeyes
    prismlauncher
    thunderbird
    dolphin-emu
    feh
    zotero
    #libreoffice-qt #disabled for now since broken
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
    #tetrio-desktop
    
    # temp
    rofi-wayland-unwrapped
    rofi-power-menu
  ];

  xdg = {
    enable = true;
    mimeApps.defaultApplications = {
      "inode/directory" = "thunar.desktop";
      "application/pdf" = "firefox.desktop";
      "image/png" = "feh.desktop";
      "application/zip" = "ark.desktop";
      "text/css" = "nvim.desktop";
    };
  };

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
