{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disables the greeting
    '';
    shellAbbrs = {
      n = "cd ~/.nix_config/";
    };
  };
}
