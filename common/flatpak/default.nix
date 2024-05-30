{...}: {
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    #packages = [];
    overrides = {
      global = {
        # Force Wayland by default
        Context.sockets = ["wayland" "!x11" "!fallback-x11"];

        Environment = {
          # Fix un-themed cursor in some Wayland apps
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

          # Force correct theme for some GTK apps
          #GTK_THEME = "Adwaita:dark"; #TODO: Do some nix fuckery to get this value updating from elsewhere in the config
        };
      };
    };
  };

  # Add flatpak installation location to the path
  # This allows apps installed as a flatpak to be visible in any runners like rofi
  environment.sessionVariables.PATH = [
    "/var/lib/flatpak/exports/share/applications/"
  ];
}
