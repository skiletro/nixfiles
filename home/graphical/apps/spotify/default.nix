{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.spicetify.homeManagerModules.default];

  config = lib.mkIf osConfig.userConfig.programs.graphical.spotify.enable {
    programs.spicetify = let
      spicetify = inputs.spicetify.legacyPackages.${pkgs.system};
    in {
      enable = true;
      #theme = spicetify.themes.text;

      enabledExtensions = with spicetify.extensions; [
        songStats
      ];

      enabledCustomApps = with spicetify.apps; [
        # nameThatTune
        # lyrics-plus
      ];
    };
  };
}
