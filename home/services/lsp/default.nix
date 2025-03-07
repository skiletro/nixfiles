{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.services.lsp.enable {
    home.packages = with pkgs; [
      bash-language-server # Bash
      gopls # Go
      marksman # Markdown
      nil # Nix
      omnisharp-roslyn # C#
      taplo # TOML
      typescript-language-server # Javascript/Typescript
      vscode-langservers-extracted # HTML/CSS/JSON/ESLint
    ];
  };
}
