{
  config,
  lib,
  pkgs,
  ...
}: {
  options.userConfig.gaming.emulators.enable = lib.mkEnableOption "Retro Console Emulators";

  config = lib.mkIf config.userConfig.gaming.emulators.enable {
    environment.systemPackages = with pkgs; [
      dolphin-emu # Wii, Gamecube
      ryujinx # Switch
      cemu # Wii U
    ];

    services.flatpak.packages = [
      "io.github.TeamWheelWizard.WheelWizard" # mkwii mod manager
    ];
  };
}
