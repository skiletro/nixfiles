{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf config.eos.programs.gaming.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # Wayland
      openFirewall = true;
      applications.apps =
        lib.lists.forEach [
          {
            name = "Desktop";
            auto-detach = "true";
          }
          {
            name = "Steam Big Picture";
            detached = ["${lib.getExe' pkgs.util-linux "setsid"} ${lib.getExe pkgs.steam} steam://open/bigpicture"]; # TODO: This doesn't work all of the time.
          }
          {
            name = "Pegasus";
            cmd = "kstart ${lib.getExe pkgs.pegasus-frontend}";
          }
        ] (attr:
          attr
          // {
            exclude-global-prep-cmd = "false";
            prep-cmd = let
              kscreen = lib.getExe pkgs.kdePackages.libkscreen;
            in [
              {
                do = "sh -c \"${kscreen} output.DP-2.mode.\${SUNSHINE_CLIENT_WIDTH}x\${SUNSHINE_CLIENT_HEIGHT}@\${SUNSHINE_CLIENT_FPS}\"";
                undo = "${kscreen} output.DP-2.mode.3440x1440@165";
              }
            ];
          });
    };
  };
}
