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

  options.eos.internal.steamUserID = lib.mkOption {
    default = "356380405"; #/id/skiletro
  };

  config = lib.mkIf osConfig.eos.programs.gaming.enable {
    programs.steam.localConfig = {
      enable = true;
      closeSteam = true; # Closes Steam automatically before writing any changes.
    };
  };
}
