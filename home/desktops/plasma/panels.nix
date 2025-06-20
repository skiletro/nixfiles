{
  osConfig,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (osConfig.eos.system.desktop == "plasma") {
    age.secrets.weather-plasmoid-location.file = ../../secrets/weather-plasmoid-location.age;

    programs.plasma.panels = [
      {
        location = "top";
        height = 22;
        lengthMode = "fill";
        screen = "all";
        widgets = [
          {
            name = "org.dhruv8sh.kara";
            config = {
              general = {
                spacing = "3";
                type = "0";
              };
              type1.t1activeWidth = "25";
            };
          }
          {
            name = "org.kde.windowtitle";
            config.General = {
              filterActivityInfo = "false";
              showIcon = "false";
              useActivityIcon = "false";
            };
          }
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.colorpicker"
          "org.kde.plasma.systemtray"
          {
            name = "org.kde.plasma.weather";
            config = {
              Appearance.showTemperatureInCompactMode = "true";
              Units = {
                pressureUnit = "5028";
                speedUnit = "9002";
                temperatureUnit = "6001";
                visibilityUnity = "2024";
              };
              WeatherStation.source = builtins.readFile config.age.secrets.weather-plasmoid-location.path; # This is fine because if you have access to my nix store, I have bigger problems than you knowing where I live.
            };
          }
          {
            name = "org.kde.plasma.digitalclock";
            config.Appearance = {
              customDateFormat = "ddd, d MMM yyyy";
              dateDisplayFormat = "BesideTime";
              dateFormat = "custom";
              # fontFamily = "M+2 Nerd Font";
              # fontStyleName = "Regular";
              # fontWeight = "400";
              # use24hFormat = "0";
            };
          }
          {
            name = "org.latgardi.darwinmenu";
            config.General = {
              customButtonImage = "xfce-wm-menu";
              fixedIconSize = "22";
              icon = "start-here-kde-symbolic";
              iconSizePercent = "99";
              resizeIconToRoot = "true";
              useCustomButtonImage = "true";
              useFixedIconSize = "true";
              useRectangleButtonShape = "false";
            };
          }
        ];
      }
      {
        location = "left";
        height = 56;
        lengthMode = "fit";
        hiding = "dodgewindows";
        widgets = ["org.kde.plasma.icontasks"];
      }
    ];
  };
}
