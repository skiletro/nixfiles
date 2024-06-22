{lib, ...}: {
  imports = [
    ./hyprland.nix
    ./plasma.nix
  ];

  options = {
    userConfig.desktop = {
      enable = lib.mkEnableOption "Desktop environment and graphical applications";
      environments = lib.mkOption {
        type = lib.types.listOf (lib.types.enum [
          "hyprland"
          "plasma"
        ]);
        default = [];
        description = "Specify the desktop environments to use";
      };
      terminalEmulator = lib.mkOption {
        type = lib.types.enum ["alacritty" "kitty"];
        default = "alacritty";
        description = "Specify the terminal emulator to install";
      };
      scaling = {
        enable = lib.mkEnableOption "Desktop scaling (not compatible with Plasma/Gnome)";
        multiplier = lib.mkOption {
          default = 1.5;
          example = 1.25;
          type = lib.types.float;
          description = "Scaling multiplier";
        };
      };
      isWayland = lib.mkEnableOption ""; # FIXME
    };
  };
}
