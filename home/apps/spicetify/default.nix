{
  pkgs,
  inputs,
  ...
}: {
  programs.spicetify = {
    enable = true;
    theme = inputs.spicetify-nix.packages.${pkgs.system}.default.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with inputs.spicetify-nix.packages.${pkgs.system}.default.extensions; [
      # empty :(
    ];

    enabledCustomApps = with inputs.spicetify-nix.packages.${pkgs.system}.default.apps; [
      nameThatTune
      lyrics-plus
    ];
  };
}