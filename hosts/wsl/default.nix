{...}: {
  userConfig = {
    graphical = false;
    graphical.emacs = true;
  };

  wsl.enable = true;

  system.stateVersion = "24.11";
}
