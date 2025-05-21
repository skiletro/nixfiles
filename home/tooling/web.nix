{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.eos.tooling.web.enable {
    home.packages = with pkgs; [
      typescript-language-server
      vscode-langservers-extracted
      bun
      emmet-ls
    ];
  };
}
