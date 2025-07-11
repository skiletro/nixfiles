{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config.eos.system) user;
in {
  config = {
    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos;

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

    # Networking
    networking = {
      useDHCP = lib.mkDefault true;
      networkmanager.enable = true;
    };
    # Environment settings
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Hints to apps that Wayland is being used
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"; # Font Stem Darkening - Looks better
      SAL_USE_VCLPLUGIN = "gtk3"; # Global menu support
      GTK_MODULES = lib.mkIf (config.eos.system.desktop == "plasma") "appmenu-gtk-module"; # Global menu support
    };

    # System-wide privileges
    security.polkit.enable = true;

    # Run unpatched dynamic binaries on NixOS
    programs = {
      nix-ld.enable = true;
      command-not-found.enable = false;
    };

    system.stateVersion = "23.11";

    age.identityPaths = ["/home/${user}/.ssh/id_ed25519"];
  };
}
