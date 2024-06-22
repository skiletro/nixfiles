{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.desktop.enable {
    home.packages = with pkgs; [
      cava
      playerctl
      brightnessctl
      pamixer
      upower
      sway-contrib.grimshot #screenshots
      wtype
    ];
  };
}
