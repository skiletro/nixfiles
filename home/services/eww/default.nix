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

    home.packages = with pkgs; [
      socat # Needed for some scripts
      alacritty # Temporary, until I can implement the "term" features properly
    ];
  };
}
