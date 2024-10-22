{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.terminal.utils.enable {
    programs.eza = {
      enable = true;
      icons = "auto";
    };
  };
}
