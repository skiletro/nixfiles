{ config, pkgs, lib, inputs, ... }:

{

  imports = [
    # Users
    ./jamie

    # Settings
    ./gtk

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
    wl-clipboard
    wtype
    fzf
    python311
    nodejs_18

    #gui
    xfce.thunar
    beeper
    bitwarden
    obsidian
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
    vial
    onedrivegui
    libsForQt5.ark
    pavucontrol

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
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    tetrio-desktop
    
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
    };
  };

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
