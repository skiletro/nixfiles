{...}: {
  userConfig = {
    graphical = {
      enable = false;
      emacs.enable = true;
    };
  };

  wsl = {
    enable = true;
    defaultUser = "jamie";
    useWindowsDriver = true;
    wslConf.automount.enabled = true;
  };

  system.stateVersion = "24.11";
}
