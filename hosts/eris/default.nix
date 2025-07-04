{
  pkgs,
  inputs',
  ...
}: {
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
      blender # You know what blender is
      flare-signal # Signal Client
      fractal # Matrix Client
      fsearch # Fast File Search
      inputs'.photogimp.packages.default
      godot_4 # Godot Engine
      handbrake # Video Encoder
      impression # ISO Burner
      itch # Itch.io Client
      kdiskmark # Drive Benchmark Tool
      libreoffice # Office Suite
      ludusavi # Game Save Backup Manager
      obs-studio # Screen Recording and Broadcast Suite
      okteta # Hex Editor
      proton-pass
      qbittorrent # Torrent Client
      tenacity # Audio Editor
      video-trimmer # Trims Videos
      vlc # Media Player, mostly used for m3u files

      # Terminal
      ffmpeg # Manipulate Video
      imagemagick # Manipulate Images
    ];
  };
}
