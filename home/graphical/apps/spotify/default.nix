{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.spicetify.homeManagerModule];

  config = lib.mkIf osConfig.userConfig.programs.graphical.spotify.enable {
    programs.spicetify = let
      spicetify = inputs.spicetify.packages.${pkgs.system}.default;
    in {
      enable = true;
      theme = spicetify.themes.catppuccin;
      colorScheme = "mocha";

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
