{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./greeter.nix
  ];

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
    direnv
    git
    neovim
  ];

  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  # Configure keymap in X11
  services.xserver.layout = "gb";

  # Bigger/better tty font
  console = {
    keyMap = "uk"; # Configure console keymap
    earlySetup = true; # Runs as soon as possible
    #font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    #packages = with pkgs; [ terminus_font ];
    colors = [
      "1e1e2e"
      "f38ba8"
      "a6e3a1"
      "f9e2af"
      "89b4fa"
      "f5c2e7"
      "94e2d5"
      "bac2de"
      "585b70"
      "f38ba8"
      "a6e3a1"
      "f9e2af"
      "89b4fa"
      "f5c2e7"
      "94e2d5"
      "a6adc8"
    ];
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
  ];

  # Virtualisation settings
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Global variables (environment)
  environment.sessionVariables = rec {
    FLAKE = "/home/jamie/.nix_config";
    NIXOS_OZONE_WL = "1"; # Hints to apps that I'm using Wayland
    PATH = [
      "/var/lib/flatpak/exports/share/applications/"
    ];
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock.text = ''
      auth include login
    '';
  };

  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    gnome.gnome-keyring.enable = true; # Saves passwords
    flatpak.enable = true;

    # Printing
    printing = {
      enable = true;
      drivers = with pkgs; [hplip]; # HP proprietary drivers
    };
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true; # For WiFi printers
    };
  };

  fonts = {
    fontDir.enable = true;

    packages =
      (with pkgs; [
        corefonts #ms fonts
        vistafonts #more ms fonts
        noto-fonts
        noto-fonts-extra
        noto-fonts-cjk #Japanese, Korean, Chinese, etc
        noto-fonts-color-emoji
        (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
        iosevka-comfy.comfy
      ])
      ++ [
        inputs.myfonts.packages.${pkgs.system}.urbanist
      ];

    fontconfig = {
      enable = true;
      localConf = ''
        <match target="pattern">
          <test qual="any" name="family" compare="eq"><string>Iosevka Comfy</string></test>
          <edit name="family" mode="assign" binding="same"><string>SymbolsNerdFont</string></edit>
        </match>
      '';
      defaultFonts = {
        monospace = ["Iosevka Comfy" "SymbolsNerdFont" "Noto Color Emoji"];
        sansSerif = ["Urbanist" "Noto Sans" "Noto Fonts Extra"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  nix = {
    # set nix path properly
    nixPath = [
      "nixos-config=/home/jamie/.nix_config/flake.nix"
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    ];

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };

    package = pkgs.nixFlakes; # or versioned attr like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    optimise = {
      automatic = true;
      dates = [
        "03:45"
        "07:00"
      ];
    };
  };

  nh = {
    # Automatic garbage collection by nh, better than inbuilt
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
  };

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "vial_udev";
      text = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      '';
      destination = "/etc/udev/rules.d/99-vial.rules";
    }) # For vial, allows recognition of keyboards!
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
