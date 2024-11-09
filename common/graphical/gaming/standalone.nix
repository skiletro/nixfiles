{
  config,
  lib,
  ...
}: {
  options.userConfig.gaming.standalone.enable = lib.mkEnableOption "Standalone Games: Just Osu for now!";

  config = lib.mkIf config.userConfig.gaming.standalone.enable {
    services.flatpak.packages = [
      "sh.ppy.osu"
    ];
  };
}
