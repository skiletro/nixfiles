{ config, pkgs, lib, inputs, ... }:

{

  imports = [
    # Users
    ./jamie

    # Settings
    ./theming

    # Window Managers
    ./hyprland
    #./sway

    # Programs
    ./fish
    ./starship
    ./kitty
    #./foot
    ./firefox
    ./neovim
    ./vscode
    ./eww
    ./mako
    ./wofi
    ./spicetify
    ./waybar
    ./swaylock
    ./webcord
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
    fd #emacs

    #gui
    cinnamon.nemo-with-extensions
    beeper
    bitwarden
    obsidian
    emacs29-pgtk
    networkmanagerapplet
    xorg.xeyes
    blender
    prismlauncher
    thunderbird
    dolphin-emu
    feh
    zotero
    libreoffice
    obs-studio
    teams-for-linux

    # misc
    swayosd
    udiskie
    gnome.adwaita-icon-theme
    catppuccin-gtk
    catppuccin-cursors
    xdg-utils
    libsForQt5.polkit-kde-agent
    hunspell #libreoffice
    hunspellDicts.en_GB-ise #libreoffice

    # gaming
    inputs.nix-gaming.packages.${pkgs.system}.proton-ge
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    tetrio-desktop
    
    # temp
    rofi-wayland-unwrapped
    rofi-power-menu
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
