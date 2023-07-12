{ config, pkgs, lib, inputs, ... }:

{
    programs.spicetify = {
        enable = true;
        theme = inputs.spicetify-nix.packages.${pkgs.system}.default.themes.catppuccin-mocha;
        colorScheme = "mauve";

        enabledExtensions = with inputs.spicetify-nix.packages.${pkgs.system}.default.extensions; [
            # empty :(
        ];
    };
}