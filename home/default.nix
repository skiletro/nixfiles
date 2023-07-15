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
    libsForQt5.polkit-kde-agent
    upower
    acpi
    wlsunset
    cava
    cli-visualizer

    #gui
    beeper
    bitwarden
    obsidian
    emacs
    networkmanagerapplet
    xfce.thunar
    gvfs #thunar
    xorg.xeyes
    blender
    prismlauncher
    thunderbird
    #godot_4 #need to work out how to get c# support working
    #neovide #latest version doesn't work on wayland rn
    dolphin-emu

    # misc
    swayosd
    gnome.adwaita-icon-theme
    catppuccin-gtk
    catppuccin-cursors
    xdg-utils

    # gaming
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    
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
