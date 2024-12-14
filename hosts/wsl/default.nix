{inputs, ...}: {
  imports = [
    inputs.wsl.nixosModules.default
  ];

  networking.hostName = "wsl";

  userConfig = {
    system.gpu = "none";
    virtualisation.enable = false;

    programs = {
      helix.enable = true;
      lazygit.enable = true;
    };
  };

  wsl = {
    enable = true;
    defaultUser = "jamie";
    useWindowsDriver = true;
    wslConf.automount.enabled = true;
    startMenuLaunchers = true;
  };

  system.stateVersion = "24.11";
}
