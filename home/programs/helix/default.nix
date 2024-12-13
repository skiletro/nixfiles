{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.helix.enable {
    programs.helix = {
      enable = true;
      extraPackages = with pkgs; [
        bash-language-server # Bash
        gopls # Go
        marksman # Markdown
        nil # Nix
        omnisharp-roslyn # C#
        taplo # TOML
        typescript-language-server # Javascript/Typescript
        vscode-langservers-extracted # HTML/CSS/JSON/ESLint
      ];
      settings = {
        editor = {
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          indent-guides = {
            character = "‣";
            render = true;
            skip-levels = 1;
          };
        };
      };
    };
  };
}
