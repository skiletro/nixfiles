{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "eris";

  eos = {
    system = {
      gpu = "nvidia";
      greeter = "sddm";
      desktop = "plasma";
    };

    programs.extraPrograms = with pkgs; [
      # Graphical
      bitwarden-desktop # Password Manager
      element-desktop # Matrix Client
      fsearch # Fast File Search
      gimp3-with-plugins # Image Editor
      godot_4 # Godot Engine
      handbrake # Video Encoder
      impression # ISO Burner
      kdePackages.kdenlive # Libre Video Editor
      kdiskmark # Drive Benchmark Tool
      libreoffice # Office Suite
      ludusavi # Game Save Backup Manager
      obs-studio # Screen Recording and Broadcast Suite
      okteta # Hex Editor
      qbittorrent # Torrent Client
      tenacity # Audio Editor
      thunderbird-latest # Email Client
      video-trimmer # Trims Videos
      vlc # Media Player, mostly used for m3u files

      # Terminal
      ffmpeg # Manipulate Video
      imagemagick # Manipulate Images

      # Runtimes
      bun # JavaScript
      jre_minimal # Java
      python3 # Python
    ];

    services.noisetorch = {
      enable = true;
      deviceUnit = ''sys-devices-pci0000:00-0000:00:01.3-0000:03:00.0-usb1-1\x2d2-1\x2d2:1.0-sound-card2-controlC2.device''; # This changes depending on the USB socket used.
      deviceID = ''alsa_input.usb-BLUE_MICROPHONE_Blue_Snowball_201305-00.mono-fallback'';
    };
  };
}
