{
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.steam-localconfig-nix.homeModules.default];

  config = lib.mkIf osConfig.eos.programs.gaming.enable {
    programs.steam.config.enable = true;
  };
}
