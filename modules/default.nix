{
  pkgs,
  lib,
  config,
  inputs,
  self,
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

  # Networking
  networking = {
    networkmanager.enable = true;

    # Adapt rpfilter to ignore WireGuard traffic - allows WireGuard to work!
    firewall = let
      port = "51820"; # WireGuard endpoint port
    in {
      # if packets are still dropped, they will show up in dmesg
      logReversePathDrops = true;
      # wireguard trips rpfilter up
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport ${port} -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport ${port} -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport ${port} -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport ${port} -j RETURN || true
      '';
    };
  };

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
    alejandra # Nix linter
    du-dust # Fancier Looking `du`
    fd # Find files
    file # Identify files
    fzf # Fuzzy-finder
    git # You know what git is
    helix # Best editor
    jq # JSON script processor
    just # Handy way to save and run project-specific commands
    libnotify # Send notifications through scripts, handy to have
    neovim # Vim fork
    ngrok # Reverse proxy
    pamixer # PulseAudio command line mixer
    playerctl # Controls media players
    ripgrep # Grep through files
    tldr # Simplified man pages
    tmux # Terminal multiplexer
    unrar # RAR utility
    unzip # ZIP utility
    wget # Get files from command-line
    wineWowPackages.stable # Run Windows apps
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
    package = pkgs.lix;

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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm";
    users.jamie.imports = [../home];
    extraSpecialArgs = {inherit inputs self;};
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

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [];
    };
    overlays = with inputs; [
      nur.overlays.default
    ];
  };

  programs.command-not-found.enable = false;

  services.xserver.excludePackages = [pkgs.xterm];
}
