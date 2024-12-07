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
      type = "sddm";
    };

    desktop = {
      enable = true;
      environments = ["plasma"];
      terminalEmulator = "alacritty";
    };

    programs = {
      mpv.enable = true;
      neovim.enable = true;
      spotify.enable = true;
      vscode.enable = true;
    };

    gaming = {
      emulators.enable = true;
      launchers.enable = true;
      standalone.enable = true;
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
      element-desktop # Matrix Client
      inkscape # Vector Image Editor
      onlyoffice-bin # Office Suite
      plex-media-player # Plex Client
      qbittorrent # Torrent Client
      qdirstat # Storage Visualiser
      telegram-desktop # Official Telegram Client
      tenacity # Audio Editor (Audacity Fork)
      usbimager # Write Image Files to USB
      vesktop # Discord Client
      vial # QMK-based Keyboard Layout Editor

      # Runtimes
      bun # JavaScript
      jre_minimal # Java
      python3 # Python
    ]);

  programs = {
    noisetorch.enable = true; # Microphone Noise Cancellation
    obs-studio.enable = true; # Screen Recording and Broadcasting Suite
    thunderbird.enable = true; # Email Client
  };

  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Nvidia Graphics Drivers
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
  # noveau drivers don't work very well, adding this to stop them from interfering
  boot.blacklistedKernelModules = ["nouveau"];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
