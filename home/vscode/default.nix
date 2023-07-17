{ config, pkgs, lib, inputs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      mkhl.direnv
      bbenoist.nix
      catppuccin.catppuccin-vsc
      vscode-icons-team.vscode-icons
      #eww-yuck.yuck
    ];
    userSettings = {
      "window.menuBarVisibility" = "toggle";
      "editor.fontFamily" = "'Iosevka Eos', 'Droid Sans Mono', 'monospace', monospace";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "vscode-icons";
      "vsicons.dontShowNewVersionMessage" = true;
      "editor.fontLigatures" = true;
    };
  };
}
