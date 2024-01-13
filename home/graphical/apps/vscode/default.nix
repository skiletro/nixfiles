{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      kamadorueda.alejandra
      catppuccin.catppuccin-vsc
      vscode-icons-team.vscode-icons
      #eww-yuck.yuck
    ];
    userSettings = {
      "update.mode" = "none";
      "extensions.autoUpdate" = false; # This stuff fixes vscode freaking out when theres an update

      "window.menuBarVisibility" = "toggle";
      "editor.fontFamily" = "'Iosevka Comfy', 'SymbolsNerdFont', 'monospace', monospace";
      "terminal.integrated.fontFamily" = "'Iosevka Comfy', 'SymbolsNerdFont'";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "vscode-icons";
      "vsicons.dontShowNewVersionMessage" = true;
      "editor.fontLigatures" = true;
      "editor.minimap.enabled" = false;

      "window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509
    };
  };

  programs.fish.shellAbbrs = {
    code = "codium";
  };
}
