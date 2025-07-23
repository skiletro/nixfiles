{
  pkgs,
  inputs',
  ...
}: {
  eos = {
    system = {
      gpu = "nvidia";
      greeter = "gdm";
      desktop = "gnome";
    };

    programs.extraPrograms = with pkgs; [
      # Graphical
      bitwarden-desktop # Old password manager - still there for any passwords I forgot to transfer over.
      blender # You know what blender is
      flare-signal # Signal Client
      fractal # Matrix Client
      fsearch # Fast File Search
      ghex # Hex Editor
      inputs'.photogimp.packages.default
      godot_4 # Godot Engine
      handbrake # Video Encoder
      impression # ISO Burner
      inkscape-with-extensions
      itch # Itch.io Client
      kdiskmark # Drive Benchmark Tool
      libreoffice # Office Suite
      ludusavi # Game Save Backup Manager
      obs-studio # Screen Recording and Broadcast Suite
      proton-pass # Password manager
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
