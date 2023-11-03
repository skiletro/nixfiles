{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disables the greeting
      alias cat="bat"
      fish_add_path /home/jamie/.config/emacs/bin # for doom emacs ;p
    '';
  };
}
