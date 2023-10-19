{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./greeter.nix
  ];

  users.users.jamie.extraGroups = ["users" "networkmanager" "wheel" "libvirtd"];

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
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    #xdg-desktop-portal-hyprland
  ];

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
        noto-fonts-emoji
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
        emoji = ["Noto Color Emoji"];
        monospace = ["Iosevka Comfy"];
        sansSerif = ["Urbanist"];
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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
