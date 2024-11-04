{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.spicetify.homeManagerModules.default];

  config = lib.mkIf osConfig.userConfig.programs.spotify.enable {
    programs.spicetify = let
      spicetify = inputs.spicetify.legacyPackages.${pkgs.system};
    in {
      enable = true;

      enabledExtensions = with spicetify.extensions; [
        songStats
      ];

      enabledCustomApps = with spicetify.apps; [
        newReleases
        lyricsPlus
      ];
    };
  };
}
