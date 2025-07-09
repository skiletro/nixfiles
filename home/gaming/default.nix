{
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [
    inputs.steam-localconfig-nix.homeModules.default
    ./cs2.nix
  ];

  config = lib.mkIf osConfig.eos.programs.gaming.enable {
    programs.steam.config.enable = true;
  };
}
