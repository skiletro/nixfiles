{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./chrome
    ./emacs
    ./firefox
    ./mpv
    ./spotify
    ./vscode
  ];

  config = lib.mkIf osConfig.userConfig.programs.graphical.enable {
    home.packages = with pkgs; [
      bitwarden-desktop # Password Manager
      element-desktop # Matrix Client
      fusee-interfacee-tk # Graphical Switch RCM Tool
      inkscape # Vector Image Editor
      obs-studio # Screen Recording and Broadcasting Suite
      onlyoffice-bin # Office Suite
      plex-media-player # Plex Client
      qbittorrent # Torrent Client
      qdirstat # Storage Visualiser
      telegram-desktop # Official Telegram Client
      tenacity # Audio Editor (Audacity Fork)
      thunderbird # Email Client
      usbimager # Write Image Files to USB
      vial # QMK-based Keyboard Layout Editor
      video-trimmer # Trim videos quickly, doesn't do much else
      webcord # Discord Client
    ];
  };
}
