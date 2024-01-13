{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disables the greeting
        fish_add_path /home/jamie/.config/emacs/bin # for doom emacs ;p
    '';
  };
}
