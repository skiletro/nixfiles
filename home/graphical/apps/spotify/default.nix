{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.spicetify.homeManagerModule];
  programs.spicetify = let
    spicetify = inputs.spicetify.packages.${pkgs.system}.default;
  in {
    enable = true;
    theme = spicetify.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with spicetify.extensions; [
      # empty :(
    ];

    enabledCustomApps = with spicetify.apps; [
      nameThatTune
      lyrics-plus
    ];
  };
}
