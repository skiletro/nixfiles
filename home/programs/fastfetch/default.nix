{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [fastfetch];

    programs.bash.shellAliases = {neofetch = "fastfetch";};
    programs.fish.shellAliases = {neofetch = "fastfetch";};
    programs.zsh.shellAliases = {neofetch = "fastfetch";};
  };
}
