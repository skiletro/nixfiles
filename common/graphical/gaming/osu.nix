{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf config.userConfig.programs.graphical.gaming.osu.enable {
    services.flatpak.packages = [
      "sh.ppy.osu"
    ];
  };
}
