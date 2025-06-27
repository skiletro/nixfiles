{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "eris";

  eos = {
    system = {
      gpu = "nvidia";
      greeter = "gdm";
      desktop = "gnome";
    };

    programs.extraPrograms = with pkgs; [
      # Graphical
      bitwarden-desktop # Password Manager
      flare-signal # Signal Client
      fractal # Matrix Client
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
  };
}
