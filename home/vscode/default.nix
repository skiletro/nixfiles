{pkgs, ...}: {
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
      "update.mode" = "none";
      "extensions.autoUpdate" = false; # This stuff fixes vscode freaking out when theres an update

      "window.menuBarVisibility" = "toggle";
      "editor.fontFamily" = "'Iosevka Comfy', 'SymbolsNerdFont', 'monospace', monospace";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "vscode-icons";
      "vsicons.dontShowNewVersionMessage" = true;
      "editor.fontLigatures" = true;
      "editor.minimap.enabled" = false;
    };
  };
}
