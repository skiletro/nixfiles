{
  lib,
  config,
  ...
}: {
  options = {
    userConfig.programs.terminal = {
      neovim.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enables Neovim";
      };
      utils.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enables Terminal Utilities";
      };
      extras.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enables Terminal Extras";
      };
    };
  };

  config.userConfig.programs.terminal = {
    neovim.enable = true;
    utils.enable = true;
    extras.enable = true;
  };
}
