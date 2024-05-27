{
  lib,
  config,
  ...
}: {
  options = {
    customConfig.flatpak.enable = lib.mkEnableOption "Enable Flatpak Support";
  };

  config = lib.mkIf config.customConfig.flatpak.enable {
    services.flatpak = {
      enable = true;
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
      packages = [];
    };

    # Add flatpak installation location to the path
    # This allows apps installed as a flatpak to be visible in any runners like rofi
    environment.sessionVariables.PATH = [
      "/var/lib/flatpak/exports/share/applications/"
    ];
  };
}
