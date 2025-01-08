{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "eris";

  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

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
      terminalEmulator = "ghostty";
    };

    programs = {
      discord.enable = true;
      helix.enable = true;
      lazygit.enable = true;
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
    bitwarden-desktop # Password Manager
    (chromium.override {enableWideVine = true;}) # For Netflix, etc.
    eyedropper # Color Picker
    filezilla # FTP Client
    fractal # Matrix Client
    fsearch # Fast File Search
    gnome-builder # GNOME-based IDE
    handbrake # Video Encoder
    impression # ISO Burner
    kdiskmark # Drive Benchmark Tool
    libreoffice # Office Suite
    ludusavi # Game Save Backup Manager
    qbittorrent # Torrent Client
    sqlitebrowser # DB Browser for SQLite
    telegram-desktop # Official Telegram Client
    tenacity # Audio Editor (Audacity Fork)
    video-trimmer # Trims... Videos...

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

  services.hardware.openrgb.enable = true;

  # Fixes refresh rate in GDM for my monitor
  systemd.tmpfiles.rules = let
    monitorXml = ''
      <monitors version="2">
        <configuration>
          <layoutmode>logical</layoutmode>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-2</connector>
                <vendor>LHC</vendor>
                <product>eiQ-34H/HQ-V2</product>
                <serial>0000000000000</serial>
              </monitorspec>
              <mode>
                <width>3440</width>
                <height>1440</height>
                <rate>165.001</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
      </monitors>
    '';
  in [
    "L /run/gdm/.config/monitors.xml - - - - ${monitorXml}"
  ];

  system.stateVersion = "23.11";
}
