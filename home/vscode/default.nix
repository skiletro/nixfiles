{ config, pkgs, lib, inputs, ... }:

{

  programs.vscode = {
    
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      catppuccin.catppuccin-vsc
    ];

  };

}
