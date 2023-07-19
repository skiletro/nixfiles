{ config, pkgs, ... }:

{
  users.users.jamie = {
    isNormalUser = true;
    description = "Jamie";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.fish;
    packages = with pkgs; [ ];
  }; programs.fish.enable = true;

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

  # Configure console keymap
  console.keyMap = "uk";

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    layout = "gb";
    xkbVariant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages that need to be accessable globally
  environment.systemPackages = with pkgs; [ 
    virt-manager
  ];

  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "1";
    NEOVIDE_MULTIGRID = "1";
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock.text = ''
      # PAM configuration file for swaylock. By default it includes
      # the "login" configuration file (see /etc/pam.d/login)
      auth include login
    '';
  };

  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    gnome.gnome-keyring.enable = true;
    printing.enable = true;
  };

  fonts = {
    fonts = with pkgs; [
      corefonts
      noto-fonts-emoji
      (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
      # Iosevka takes a LONG time to compile (for a font anyway), you've been warned.
      (iosevka.override { privateBuildPlan = builtins.readFile ./iosevka-font-patches.toml; set = "eos"; })
    ];

    fontconfig = {
      localConf = ''
      <match target="pattern">
        <test qual="any" name="family" compare="eq"><string>Iosevka Eos</string></test>
        <edit name="family" mode="assign" binding="same"><string>SymbolsNerdFont</string></edit>
      </match>
      '';
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Iosevka Eos" ];
        sansSerif = [ "Iosevka Eos" ];
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
      substituters = [
       "https://hyprland.cachix.org"
       "https://nix-gaming.cachix.org"
       "https://webcord.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "webcord.cachix.org-1:l555jqOZGHd2C9+vS8ccdh8FhqnGe8L78QrHNn+EFEs="
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

  # steam is a system-wide package, not a home-manager package
  # something something grumble grumble
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

}
