{
  lib,
  pkgs,
  config,
  ...
}: {
  options.userConfig.gaming.gamestreaming.enable = lib.mkEnableOption "Game streaming backend";

  config = lib.mkIf config.userConfig.gaming.gamestreaming.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # Wayland
      openFirewall = true;
      applications.apps =
        lib.lists.forEach [
          {
            name = "Desktop";
            exclude-global-prep-cmd = "false";
            auto-detach = "true";
          }
          {
            name = "Pegasus";
            exclude-global-prep-cmd = "false";
            cmd = "kstart ${lib.getExe pkgs.pegasus-frontend}";
          }
        ] (attr:
          attr
          // {
            prep-cmd = [
              {
                do = ''${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-2.mode.1280x800@60''; # TODO: Don't hardcode this stuff
                undo = ''${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-2.mode.3440x1440@165'';
              }
            ];
          });
    };
  };
}
