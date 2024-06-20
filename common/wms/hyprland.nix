{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    userConfig.windowManager.hyprland = {
      enable = lib.mkEnableOption "Hyprland";
      scaling = {
        enable = lib.mkEnableOption "Hyprland scaling";
        multiplier = lib.mkOption {
          default = 1.5;
          example = 1.25;
          type = lib.types.float;
          description = "Scaling multiplier";
        };
      };
    };
  };

  config = lib.mkIf config.userConfig.windowManager.hyprland.enable {
    programs.hyprland.enable = true; # Required to enable critical components needed to run Hyprland properly
    services.gnome.gnome-keyring.enable = true; # Saves passwords
    # The rest of Hyprland settings can be found in home manager config
  };
}
