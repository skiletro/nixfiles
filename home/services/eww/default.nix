{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.windowManager.hyprland.enable {
    programs.eww = {
      enable = true;
      configDir = ./config;
    };
  };
}
