{ config, pkgs, ... }:

{
  users.users.jamie = {
    isNormalUser = true;
    description = "Jamie";
    extraGroups = [ "networkmanager" "wheel" ];
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
    layout = "gb";
    xkbVariant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages that need to be accessable globally
  environment.systemPackages = with pkgs; [ ];

  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "1";
    NEOVIDE_MULTIGRID = "1";
  };

  security.polkit.enable = true;

  services.printing.enable = true;

  services.gnome.gnome-keyring.enable = true;

  fonts = {
    fonts = with pkgs; [
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
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
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

}
