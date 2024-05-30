{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf config.customConfig.gaming.osu.enable {
    services.flatpak.packages = [
      "sh.ppy.osu"
    ];
  };
}
