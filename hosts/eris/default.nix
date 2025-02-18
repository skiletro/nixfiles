{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "eris";

  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

  userConfig = {
    greeter = {
      enable = true;
      type = "sddm";
    };

    system = {
      gpu = "nvidia";
    };

    desktop = {
      enable = true;
      environments = ["plasma"];
      terminalEmulator = "konsole";
    };

    programs = {
      chromium.enable = true; # Enables the web apps too
      discord.enable = true;
      helix.enable = true;
      lazygit.enable = true;
      spotify.enable = true;
      vial.enable = true;
      vscode.enable = true;
      zenbrowser.enable = true;
    };

    services = {
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
    bitwarden-desktop # Password Manager
    fsearch # Fast File Search
    godot_4 # Godot Engine
    handbrake # Video Encoder
    impression # ISO Burner
    kdenlive # Libre Video Editor
    kdiskmark # Drive Benchmark Tool
    libreoffice # Office Suite
    ludusavi # Game Save Backup Manager
    mixxx # DJ Software
    nextcloud-client # Nextcloud Sync
    qbittorrent # Torrent Client
    tenacity # Audio Editor
    video-trimmer # Trims Videos

    # Terminal
    ffmpeg # Manipulate Video
    imagemagick # Manipulate Images

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
