{pkgs, ...}: {
  imports = [
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
      terminalEmulator = "kitty";
    };

    programs = {
      discord.enable = true;
      helix.enable = true;
      lazygit.enable = true;
      neovim.enable = true;
      spotify.enable = true;
      vial.enable = true;
      vscode.enable = true;
      zenbrowser.enable = true;
    };

    services = {
      gpureplay.enable = true;
      noisetorch = {
        enable = true;
        deviceUnit = ''sys-devices-pci0000:00-0000:00:01.3-0000:03:00.0-usb1-1\x2d2-1\x2d2:1.0-sound-card2-controlC2.device''; # This changes depending on the USB socket used.
        deviceID = ''alsa_input.usb-BLUE_MICROPHONE_Blue_Snowball_201305-00.mono-fallback'';
      };
    };

    gaming = {
      enable = true;
      emulators.enable = true;
      vr.enable = true;
    };
  };

  # Programs
  environment.systemPackages = with pkgs; [
    # Graphical
    avidemux # Video Remuxer and Clipper
    bitwarden-desktop # Password Manager
    blackbox-terminal # Gnome Terminal Replacement
    cpu-x # Hardware Information
    element-desktop # Matrix Client
    exhibit # 3D Model Preview
    filezilla # FTP Client
    fsearch # Fast File Search
    kdiskmark # Drive Benchmark Tool
    libreoffice # Office Suite
    ludusavi # Game Save Backup Manager
    plex-desktop # Plex Client
    qbittorrent # Torrent Client
    qdirstat # Storage Visualiser
    sqlitebrowser # DB Browser for SQLite
    telegram-desktop # Official Telegram Client
    tenacity # Audio Editor (Audacity Fork)
    tor-browser # Privacy Browser
    unetbootin # ISO USB Writer
    usbimager # Write Image Files to USB

    # Terminal
    ffmpeg
    imagemagick

    # Runtimes
    bun # JavaScript
    jre_minimal # Java
    python3 # Python
  ];

  programs = {
    localsend.enable = true; # AirDrop Alternative
    obs-studio.enable = true; # Screen Recording and Broadcasting Suite
    thunderbird.enable = true; # Email Client
  };

  system.stateVersion = "23.11";
}
