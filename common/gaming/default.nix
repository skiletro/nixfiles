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
    customConfig.gaming = {
      enable = lib.mkEnableOption "Gaming";

      emulators.enable = lib.mkEnableOption "Emulators";
      minecraft.enable = lib.mkEnableOption "Minecraft";
      osu.enable = lib.mkEnableOption "Osu";
      steam.enable = lib.mkEnableOption "Steam";
      vr.enable = lib.mkEnableOption "Virtual Reality";
    };
  };

  config = lib.mkIf config.customConfig.gaming.enable {
    customConfig.gaming = {
      emulators.enable = lib.mkDefault true;
      minecraft.enable = lib.mkDefault true;
      osu.enable = lib.mkDefault true;
      steam.enable = lib.mkDefault true;
      vr.enable = lib.mkDefault true;
    };

    programs.steam = lib.mkIf config.customConfig.gaming.enable {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}
# config = lib.mkIf osConfig.customConfig.gaming.osu.enable {
#   services.flatpak.packages = [
#     "sh.ppy.osu"
#   ];
# };

