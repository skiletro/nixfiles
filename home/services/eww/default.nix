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

    # Temporary, until I can implement the "term" features properly
    home.packages = with pkgs; [
      alacritty
    ];
  };
}
