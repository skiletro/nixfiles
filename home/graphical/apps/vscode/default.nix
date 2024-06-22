{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.graphical.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = let
        input = inputs.vscode-extensions.extensions.${pkgs.system};
        vsx = input.open-vsx;
        vcm = input.vscode-marketplace;
      in
        (with vsx; [
          # Open VSX Registry
          jnoortheen.nix-ide
          kamadorueda.alejandra
          catppuccin.catppuccin-vsc
          vscode-icons-team.vscode-icons
          skellock.just
          mkhl.direnv
          haskell.haskell
          justusadam.language-haskell
          golang.go
          james-yu.latex-workshop
        ])
        ++ (with vcm; [
          # VSCode Marketplace by Microsoft 🤢
          eww-yuck.yuck
        ]);
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
        "editor.cursorSmoothCaretAnimation" = "on";

        "window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509
      };
    };

    programs.fish.shellAbbrs = {
      code = "codium";
    };
  };
}
