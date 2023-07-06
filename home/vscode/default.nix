{ config, pkgs, lib, inputs, ... }:

{

  programs.vscode = {
    
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      mkhl.direnv
      bbenoist.nix
      catppuccin.catppuccin-vsc
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
    };

  };

}
