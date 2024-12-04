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
    ./modules
    ./styling
    ./virtualisation
    ./wms
  ];

  # Use latest kernel package
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

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
    alejandra
    gh
    git
    neovim
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

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  # Environment settings
  environment = {
    variables = {
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"; # Font Stem Darkening - Looks better
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Hints to apps that Wayland is being used
    };
  };

  security.polkit.enable = true;

  # Run unpatched dynamic binaries on NixOS
  programs.nix-ld.enable = true;
  # Nix
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
      substituters = [];
      trusted-public-keys = [];
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
}
