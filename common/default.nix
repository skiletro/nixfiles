{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    ./flatpak
    ./graphical
    ./greeters
    ./modules
    ./nixconf
    ./virtualisation
    ./wms
  ];

  stylix = {
    enable = true;

    # Color scheme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";

    # Wallpaper
    image = let
      input = pkgs.fetchurl {
        #url = "https://i.imgur.com/b0H66vt.jpeg";
        #sha256 = "sha256-BhYzihD72Zpf4Rjds+b5gWweSl2NAMeRcLADLF4rsWs=";
        url = "https://w.wallhaven.cc/full/d6/wallhaven-d6y12l.jpg";
        sha256 = "sha256-eMfcl2bPqHTP6KiWt9CHuysQs+3ZEsZlNgAYz/vS0/Y=";
      };
    in
      pkgs.runCommand "output.png" {} ''
        ${pkgs.lutgen}/bin/lutgen apply ${input} -o $out -- ${builtins.concatStringsSep " " (with config.lib.stylix.colors; [
          base00
          base01
          base02
          base03
          base04
          base05
          base06
          base07
          base08
          base09
          base0A
          base0B
          base0C
          base0D
          base0E
          base0F
        ])}
      ''; # FIXME: Could be simplified

    # Cursors
    cursor = {
      package = inputs.cursors.packages.${pkgs.system}.apple-cursor.override {
        background_color = "#${config.lib.stylix.colors.base00}";
        outline_color = "#${config.lib.stylix.colors.base06}";
        accent_color = "#${config.lib.stylix.colors.base00}";
      };
      name = "Apple-Custom";
      size = 24;
    };

    # Fonts
    fonts = {
      sansSerif = {
        package = pkgs.nerdfonts.override {fonts = ["MPlus"];};
        name = "M+2 Nerd Font";
      };
      serif = config.stylix.fonts.sansSerif; # Set serif font to the same as the sans-serif
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["MPlus"];};
        name = "M+1Code Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 10;
      };
    };
  };

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
    direnv
    git
    neovim
  ];

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

  console.keyMap = "uk";

  # Global environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hints to apps that Wayland is being used
  };

  security.polkit.enable = true;

  # Run unpatched dynamic binaries on NixOS
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}
