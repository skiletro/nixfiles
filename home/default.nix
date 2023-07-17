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
    beeper
    bitwarden
    obsidian
    emacs29-pgtk
    networkmanagerapplet
    xorg.xeyes
    blender
    prismlauncher
    thunderbird
    #godot_4 #need to work out how to get c# support working
    #neovide #latest version doesn't work on wayland rn
    dolphin-emu

    # misc
    swayosd
    udiskie
    gnome.adwaita-icon-theme
    catppuccin-gtk
    catppuccin-cursors
    xdg-utils
    libsForQt5.polkit-kde-agent

    # gaming
    inputs.nix-gaming.packages.${pkgs.system}.proton-ge
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    
    # temp
    rofi-wayland-unwrapped
    rofi-power-menu
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
