{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "eris";

  userConfig = {
    greeter = {
      enable = true;
      type = "gdm";
    };

    system = {
      gpu = "nvidia";
    };

    desktop = {
      enable = true;
      environments = ["gnome"];
      terminalEmulator = "alacritty";
    };

    programs = {
      helix.enable = true;
      lazygit.enable = true;
      mpv.enable = true;
      neovim.enable = true;
      spotify.enable = true;
      vscode.enable = true;
    };

    gaming = {
      enable = true;
      emulators.enable = true;
      vr.enable = true;
    };
  };

  # Programs
  environment.systemPackages =
    [
      inputs.zen-browser.packages.${pkgs.system}.specific # Firefox-based Browser
    ]
    ++ (with pkgs; [
      # Graphical
      avidemux # Video Remuxer and Clipper
      bitwarden-desktop # Password Manager
      cpu-x # Hardware Information
      element-desktop # Matrix Client
      filezilla # FTP Client
      fsearch # Fast File Search
      gnome-music # Music Player
      inkscape # Vector Image Editor
      kdiskmark # Drive Benchmark Tool
      ludusavi # Game Save Backup Manager
      onlyoffice-bin # Office Suite
      plex-media-player # Plex Client
      qbittorrent # Torrent Client
      qdirstat # Storage Visualiser
      sqlitebrowser # DB Browser for SQLite
      telegram-desktop # Official Telegram Client
      tenacity # Audio Editor (Audacity Fork)
      tor-browser # Privacy Browser
      unetbootin # ISO USB Writer
      usbimager # Write Image Files to USB
      vesktop # Discord Client
      vial # QMK-based Keyboard Layout Editor

      # Terminal
      imagemagick

      # Runtimes
      bun # JavaScript
      jre_minimal # Java
      python3 # Python
    ]);

  programs = {
    localsend.enable = true; # AirDrop Alternative
    noisetorch.enable = true; # Microphone Noise Cancellation
    obs-studio.enable = true; # Screen Recording and Broadcasting Suite
    thunderbird.enable = true; # Email Client
  };

  system.stateVersion = "23.11";
}
