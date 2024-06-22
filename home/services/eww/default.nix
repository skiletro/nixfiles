{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.services.eww.enable {
    programs.eww = {
      enable = true;
      configDir = ./config;
    };
  };
}
