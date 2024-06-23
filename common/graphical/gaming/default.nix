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
        default =
          if config.userConfig.programs.graphical.enable
          then true
          else false;
        description = "Enables some games and gaming related programs";
      };

      emulators.enable = lib.mkEnableOption "Emulators";
      minecraft.enable = lib.mkEnableOption "Minecraft";
      osu.enable = lib.mkEnableOption "Osu";
      steam.enable = lib.mkEnableOption "Steam";
      vr.enable = lib.mkEnableOption "Virtual Reality";
    };
  };

  config = lib.mkIf config.userConfig.programs.graphical.gaming.enable {
    userConfig.programs.graphical.gaming = {
      emulators.enable = lib.mkDefault true;
      minecraft.enable = lib.mkDefault true;
      osu.enable = lib.mkDefault true;
      steam.enable = lib.mkDefault true;
      vr.enable = lib.mkDefault true;
    };

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}
