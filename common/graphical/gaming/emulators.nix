{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf config.userConfig.programs.graphical.gaming.emulators.enable {
    services.flatpak.packages = [
      "org.DolphinEmu.dolphin-emu"
      "org.ryujinx.Ryujinx"
    ];
  };
}
