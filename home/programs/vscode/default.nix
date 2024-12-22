{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.vscode.enable {
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

        "window.menuBarVisibility" = "classic";
        "window.titleBarStyle" = "custom";
        "workbench.iconTheme" = "vscode-icons";
        "vsicons.dontShowNewVersionMessage" = true;
        "editor.minimap.enabled" = false;
        "editor.cursorSmoothCaretAnimation" = "on";

        "terminal.integrated.fontFamily" = "monospace";

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
      };
    };

    programs.fish.shellAbbrs = {
      code = "codium";
    };
  };
}
