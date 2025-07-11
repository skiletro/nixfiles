{
  lib,
  config,
  ...
}: {
  options.eos.services.flatpak.enable = lib.mkEnableOption "Flatpak" // {enable = false;};

  # TODO: evaluate these options to see if they are necessary
  config = lib.mkIf config.eos.services.flatpak.enable {
    flake.modules.nixos.desktop = {
      services.flatpak = {
        enable = true;
        update.auto = {
          enable = true;
          onCalendar = "weekly";
        };
        uninstallUnmanaged = true;
        overrides = {
          global = {
            Environment = {
              # Fix un-themed cursor in some Wayland apps
              XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

              # Force correct theme for some GTK apps
              GTK_THEME = "Adwaita:dark";
            };
          };
        };
      };

      # Add flatpak installation location to the path - this allows apps
      #
      environment.sessionVariables.PATH = [
        "/var/lib/flatpak/exports/share/applications/"
      ];
    };
  };
}
