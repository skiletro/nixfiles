{ config, pkgs, lib, inputs, ... }:

{

  imports = [
    # Users
    ./jamie

    # Window Managers
    ./hyprland
    ./sway

    # Programs
    ./fish
    ./starship
    ./kitty
    ./foot
    ./neovim
    ./vscode
    ./eww
    ./mako
    ./wofi
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
    libsForQt5.polkit-kde-agent
    upower
    acpi

    #gui
    firefox
    beeper
    bitwarden
    discord
    obsidian
    emacs
    networkmanagerapplet
    xfce.thunar

    # misc
    swayosd
    papirus-icon-theme
    
    # temp
    waybar
    rofi-wayland-unwrapped
    rofi-power-menu
  ];

  gtk = {
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus";
    theme.package = pkgs.catppuccin-gtk.override {
      accents = [ "mauve"];
      size = "standard";
      variant = "mocha";

    };
    theme.name = "Catppuccin-Mocha-Standard-Mauve-dark";
    cursorTheme.package = pkgs.catppuccin-cursors.mochaMauve;
    cursorTheme.name = "Catppuccin-Mocha-Mauve-Cursors";
    cursorTheme.size = 24;
    font.name = "Iosevka Eos";
  };

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
