{config, ...}: let
  inherit (config.eos.system) user;
in {
  programs.nh = {
    # Automatic garbage collection by nh, better than inbuilt
    enable = true;
    flake = "/home/${user}/.nix_config";
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
  };
}
