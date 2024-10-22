{pkgs, ...}: {
  nix = {
    # set nix path properly
    nixPath = [
      "nixos-config=/home/jamie/.nix_config/flake.nix"
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    ];

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      substituters = [];
      trusted-public-keys = [];
    };

    #package = pkgs.nixFlakes; # or versioned attr like nixVersions.nix_2_8
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
