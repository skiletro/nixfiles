{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./flatpak
    ./graphical # Includes stuff that a non-headless system would need
    ./greeters
    ./nix
    ./terminal
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
