{
  pkgs,
  config,
  ...
}: let
  inherit (config.eos.system) user;
in {
  nix = {
    package = pkgs.lix;

    # set nix path properly
    nixPath = [
      "nixos-config=/home/${user}/.nix_config/flake.nix"
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    ];

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      trusted-users = [user "root" "@wheel"]; # Fixes some "cannot connect to socket" issues
      warn-dirty = false;
      http-connections = 50;
      log-lines = 50;
      builders-use-substitutes = true;
      substituters = [
        "https://nix-gaming.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    extraOptions = ''
      !include ${config.age.secrets.github-access-token.path}
    '';

    optimise = {
      automatic = true;
      dates = [
        "03:45"
        "07:00"
      ];
    };
  };

  age.secrets.github-access-token.file = ../../secrets/github-access-token.age;

  nixpkgs.config.allowUnfree = true;
}
