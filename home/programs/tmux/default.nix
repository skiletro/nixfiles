{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      plugins = with pkgs.tmuxPlugins; [
        catppuccin
        sensible
        yank
      ];
    };
  };
}
