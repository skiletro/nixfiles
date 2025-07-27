{
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.steam-config-nix.homeModules.default];

  config = lib.mkIf osConfig.eos.programs.gaming.enable {
    programs.steam.config.enable = true;
  };
}
