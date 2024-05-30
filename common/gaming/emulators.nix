{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf config.customConfig.gaming.emulators.enable {
    services.flatpak.packages = [
      "org.DolphinEmu.dolphin-emu"
      "org.ryujinx.Ryujinx"
    ];
  };
}
