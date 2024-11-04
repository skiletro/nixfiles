{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.wsl.nixosModules.default
  ];

  networking.hostName = "wsl";

  wsl = {
    enable = true;
    defaultUser = "jamie";
    useWindowsDriver = true;
    wslConf.automount.enabled = true;
  };

  userConfig = {
    isHeadless = true;
    virtualisation.enable = false;

    programs.neovim.enable = true;
  };

  environment.systemPackages = with pkgs; [
    zathura
  ];

  system.stateVersion = "24.11";
}
