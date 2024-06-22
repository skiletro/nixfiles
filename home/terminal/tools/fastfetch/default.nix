{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.terminal.extras.enable {
    home.packages = with pkgs; [fastfetch];

    programs.bash.shellAliases = {neofetch = "fastfetch";};
    programs.fish.shellAliases = {neofetch = "fastfetch";};
    programs.zsh.shellAliases = {neofetch = "fastfetch";};
  };
}
