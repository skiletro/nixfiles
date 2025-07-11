{config, ...}: let
  inherit (config.eos.system) user;
in {
  nix = {
    # set nix path properly
    nixPath = [
      "nixos-config=/home/${user}/.nix_config/flake.nix"
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    ];

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-users = [user "root" "@wheel"]; # Fixes some "cannot connect to socket" issues
      warn-dirty = false;
      http-connections = 50;
      log-lines = 50;
      builders-use-substitutes = true;
      accept-flake-config = true;
      lazy-trees = true;
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
