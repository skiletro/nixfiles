{inputs, ...}: {
  imports = [
    inputs.wsl.nixosModules.default
  ];

  networking.hostName = "wsl";

  wsl = {
    enable = true;
    defaultUser = "jamie";
    useWindowsDriver = true;
    wslConf.automount.enabled = true;
    startMenuLaunchers = true;
  };

  userConfig = {
    isHeadless = true;
    virtualisation.enable = false;

    programs.neovim.enable = true;
  };

  system.stateVersion = "24.11";
}
