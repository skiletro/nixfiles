{ config, pkgs, inputs, ... }:

{
  imports = [
    ./greeter.nix
  ];

  users.users.jamie = {
    isNormalUser = true;
    description = "Jamie";
    extraGroups = [ "users" "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAgrRSnsFyg9ru8G1v+u6G7muahe3N5nDmUpInhMcXrABogdzvPBxo4PFEWpARxAmUOyjvKromYmw8ClfVYWi5cwEko1jeQNBMvhLb8bax78dzVz8rmP6pksWib0pGEICa6N52XgJhJZjcZqX/7Oi6NmFqF575TDI8NOE47vf5bMVPoPQ20j/6C3Jtrrpbr7DEHCp6DwiG71UQKNbIJc3xnxKNqQ7mg/w3Be/I8niDJfZII9J0/iuxtwMsYxwdj0rvDbVrztcoGW2u5rb9H2QiIkf1X6eyUlSMWqJ1szCW2sVVOfXsS5GLtqT9nryDR2rY1eeYk6EsLzogiLk9bq4/4w== skil19"
    ];
  };
  programs.fish.enable = true;

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

  # Configure keymap in X11
  services.xserver.layout = "gb";

  # Bigger/better tty font
  console = {
    keyMap = "uk"; # Configure console keymap
    earlySetup = false; # Runs as soon as possible
    #font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    #packages = with pkgs; [ terminus_font ];
    # colors = [
    #   "1e1e2e"
    #   "f38ba8"
    #   "a6e3a1"
    #   "f9e2af"
    #   "89b4fa"
    #   "f5c2e7"
    #   "94e2d5"
    #   "bac2de"
    #   "585b70"
    #   "f38ba8"
    #   "a6e3a1"
    #   "f9e2af"
    #   "89b4fa"
    #   "f5c2e7"
    #   "94e2d5"
    #   "a6adc8"
    # ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages that need to be accessable globally
  environment.systemPackages = with pkgs; [ ];

  # Virtualisation settings
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Global variables (environment)
  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "1"; # Hints to apps that I'm using Wayland
    PATH = [
      "/var/lib/flatpak/exports/share/applications/"
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  security = {
    polkit.enable = true;
    pam.services.gtklock.text = ''
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
      drivers = with pkgs; [ hplip ]; # HP proprietary drivers
    };
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true; # For WiFi printers
    };
  };

  fonts = {
    fontDir.enable = true;

    packages = (with pkgs; [
      corefonts #ms fonts
      vistafonts #more ms fonts
      noto-fonts-emoji
      (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
      iosevka-comfy.comfy
    ]) ++ [
      inputs.myfonts.packages.${pkgs.system}.urbanist
    ];

    fontconfig = {
      localConf = ''
      <match target="pattern">
        <test qual="any" name="family" compare="eq"><string>Iosevka Comfy</string></test>
        <edit name="family" mode="assign" binding="same"><string>SymbolsNerdFont</string></edit>
      </match>
      '';
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Iosevka Comfy" ];
        sansSerif = [ "Iosevka Comfy" ];
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
       "https://webcord.cachix.org"
       "https://anyrun.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "webcord.cachix.org-1:l555jqOZGHd2C9+vS8ccdh8FhqnGe8L78QrHNn+EFEs="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      ];
    };

    package = pkgs.nixFlakes; # or versioned attr like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
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

}
