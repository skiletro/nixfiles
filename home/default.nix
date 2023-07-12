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
    ./firefox
    ./neovim
    ./vscode
    ./eww
    ./mako
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
    libsForQt5.polkit-kde-agent
    upower
    acpi
    wlsunset

    #gui
    beeper
    bitwarden
    webcord-vencord
    obsidian
    emacs
    networkmanagerapplet
    xfce.thunar
    xorg.xeyes
    blender
    prismlauncher
    godot_4

    # misc
    swayosd
    catppuccin-gtk
    catppuccin-cursors
    
    # temp
    rofi-wayland-unwrapped
    rofi-power-menu
  ];

  gtk = {
    enable = true;

    iconTheme.package = pkgs.catppuccin-papirus-folders.override {
      flavor = "mocha";
      accent = "mauve";
    };
    iconTheme.name = "Papirus-Dark";

    theme.package = pkgs.catppuccin-gtk.override {
      size = "standard";
      variant = "mocha";
    };
    theme.name = "Catppuccin-Mocha-Standard-Blue-dark";

    cursorTheme.package = pkgs.catppuccin-cursors.mochaDark;
    cursorTheme.name = "Catppuccin-Mocha-Dark-Cursors";
    cursorTheme.size = 24;

    font.name = "Iosevka Eos";
  };

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
