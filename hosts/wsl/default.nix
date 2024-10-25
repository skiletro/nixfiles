{inputs, ...}: {
  imports = [
    inputs.wsl.nixosModules.default
  ];

  networking.hostName = "wsl";

  userConfig = {
    programs.graphical.enable = false;
    virtualisation.enable = false;
  };

  wsl = {
    enable = true;
    defaultUser = "jamie";
    useWindowsDriver = true;
    wslConf.automount.enabled = true;
  };

  system.stateVersion = "24.11";
}
