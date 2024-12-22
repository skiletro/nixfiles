{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./noisetorch.nix
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
      helix.enable = true;
      lazygit.enable = true;
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
      blackbox-terminal # Gnome Terminal Replacement
      clapper # Media Player
      cpu-x # Hardware Information
      davinci-resolve # Non-Linear Video Editor
      discord-canary # Discord Client
      element-desktop # Matrix Client
      exhibit # 3D Model Preview
      filezilla # FTP Client
      fsearch # Fast File Search
      gpu-screen-recorder # ShadowPlay Replacement
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
      vial # QMK-based Keyboard Layout Editor

      # Terminal
      ffmpeg
      imagemagick

      # Runtimes
      bun # JavaScript
      jre_minimal # Java
      python3 # Python
    ]);

  programs = {
    localsend.enable = true; # AirDrop Alternative
    obs-studio.enable = true; # Screen Recording and Broadcasting Suite
    thunderbird.enable = true; # Email Client
  };

  services.udev.packages = with pkgs; [
    vial
    via
  ];

  boot.plymouth.enable = lib.mkForce false;

  boot.kernelParams = ["video=DP-2:1920x1080@60.00"];

  system.stateVersion = "23.11";
}
