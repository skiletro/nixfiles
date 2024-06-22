{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./emulators.nix
    ./osu.nix
    ./vr.nix
  ];

  options = {
    userConfig.programs.graphical.gaming = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enables Gaming";
      };

      emulators.enable = lib.mkEnableOption "Emulators";
      minecraft.enable = lib.mkEnableOption "Minecraft";
      osu.enable = lib.mkEnableOption "Osu";
      steam.enable = lib.mkEnableOption "Steam";
      vr.enable = lib.mkEnableOption "Virtual Reality";
    };
  };

  config = {
    userConfig.programs.graphical.gaming = lib.mkIf config.userConfig.programs.graphical.gaming.enable {
      emulators.enable = lib.mkDefault true;
      minecraft.enable = lib.mkDefault true;
      osu.enable = lib.mkDefault true;
      steam.enable = lib.mkDefault true;
      vr.enable = lib.mkDefault true;
    };

    programs.steam = lib.mkIf config.userConfig.programs.graphical.gaming.enable {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}
# config = lib.mkIf osConfig.userConfig.programs.graphical.gaming.osu.enable {
#   services.flatpak.packages = [
#     "sh.ppy.osu"
#   ];
# };

