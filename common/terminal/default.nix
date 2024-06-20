{lib, ...}: {
  options = {
    userConfig.terminal = {
      neovim.enable = lib.mkEnableOption "Neovim";
      zellij.enable = lib.mkEnableOption "Zellij";
    };
  };

  config = {
    userConfig.terminal = {
      neovim.enable = lib.mkDefault true;
      zellij.enable = lib.mkDefault true;
    };
  };
}
