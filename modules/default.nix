{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./flatpak
    ./graphical
    ./greeters
    ./options
    ./services
    ./styling
    ./virtualisation
    ./wms
  ];

  # Kernel
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_zen; # Performance kernel

  # Enable networking
  networking.networkmanager.enable = true;

  users.users.jamie = {
    isNormalUser = true;
    description = "Jamie";
    extraGroups = ["users" "networkmanager" "wheel" "libvirtd"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnFEMa0S9zuA5cVg+Ktazz9gEevkDCNYIDX0WAMxcAC eos"
    ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  # Bare minimum programs needed on all systems
  environment.systemPackages = with pkgs; [
    alejandra # Nix File Formatter
    du-dust # Fancier Looking `du`
    fd # Find Files
    fzf # Fuzzy-finder
    git # You know what git is
    helix # Better Editor
    jq # JSON Processor
    just # Handy way to save and run project-specific commands
    libnotify # Send Notifications Through CLI
    neovim # Vim Editor
    ngrok # Reverse Proxy
    pamixer # Pulseaudio command line mixer
    playerctl # Controls Media Players
    ripgrep # Grep Through Files
    tldr # Simplified Man Pages
    tmux # Terminal Multiplexer
    unrar # RAR Utility
    unzip # ZIP Utility
    wget # Get files from command-line
    wineWowPackages.stable # Wine
    (btop.override {
      cudaSupport = config.userConfig.system.gpu == "nvidia";
      rocmSupport = config.userConfig.system.gpu == "amd";
    })
  ];

  # Locale
  time.timeZone = "Europe/London";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  console.keyMap = "uk";
  console.earlySetup = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  # Avahi - find and connect to other devices easily
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true; # For WiFi printers
  };

  # Environment settings
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hints to apps that Wayland is being used
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"; # Font Stem Darkening - Looks better
    SAL_USE_VCLPLUGIN = "gtk3"; # Global menu support
    GTK_MODULES = "appmenu-gtk-module"; # Global menu support
  };

  # System-wide privileges
  security.polkit.enable = true;

  # Run unpatched dynamic binaries on NixOS
  programs.nix-ld.enable = true;

  # Nix settings
  nix = {
    # set nix path properly
    nixPath = [
      "nixos-config=/home/jamie/.nix_config/flake.nix"
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    ];

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"]; # Fixes some "cannot connect to socket" issues
      warn-dirty = false;
      http-connections = 50;
      log-lines = 50;
      builders-use-substitutes = true;
      substituters = [
        "https://nix-gaming.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    optimise = {
      automatic = true;
      dates = [
        "03:45"
        "07:00"
      ];
    };
  };

  programs.nh = {
    # Automatic garbage collection by nh, better than inbuilt
    enable = true;
    flake = "/home/jamie/.nix_config";
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # This section should only be used as a _LAST RESORT_
      # Using insecure packages is very dangerous
    ];
  };

  programs.command-not-found.enable = false;

  services.xserver.excludePackages = [pkgs.xterm];
}
