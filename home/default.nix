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
    #./alacritty
    ./wezterm
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
    webcord
    gnome.gnome-font-viewer
    neovide
    inkscape

    # lsp
    rust-analyzer
    nodePackages.bash-language-server #sh and bash
    zls #zig
    rnix-lsp #nix
    ccls # c and c++
    texlive.combined.scheme-medium #latex

    # misc
    gamescope
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

    # uni
    rstudio
  ];

  xdg = {
    enable = true;
    mimeApps.enable = true;
    mimeApps.defaultApplications = let
      browser = ["firefox.desktop"];
    in {
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xht" = browser;
      "application/x-extension-xhtml" = browser;
      "application/xhtml+xml" = browser;
      "text/html" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/unknown" = browser;

      "audio/*" = ["vlc.desktop"];
      "video/*" = ["vlc.desktop"];
      "image/*" = ["nomacs.desktop"];
      "text/plain" = ["nvim.desktop"];
      "application/json" = browser;
      "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
      "application/zip" = ["org.gnome.FileRoller.desktop"];

      "x-scheme-handler/msteams" = ["teams-for-linux.desktop"];
      "x-scheme-handler/element" = ["Beeper.desktop"];
      "x-scheme-handler/discord" = ["webcord.desktop"];
      "x-scheme-handler/spotify" = ["spotify.desktop"];
      "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
    };
  };

  fonts.fontconfig.enable = true;

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
