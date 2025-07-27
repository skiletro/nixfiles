{
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.steam-localconfig-nix.homeModules.default];

  config = lib.mkIf osConfig.eos.programs.gaming.enable {
    programs.steam.config = {
      enable = true;
      closeSteam = true;
      apps = let
        appIds = [
          "620980" # Beat Saber
          "963930" # Contractors
          "1012790" # Into the Radius
          "2519830" # Resonite
          "801550" # Vail VR
        ];

        launchOptions = ''env -u TZ PRESSURE_VESSEL_FILESYSTEMS_RW="$XDG_RUNTIME_DIR/wivrn/comp_ipc" %command%'';
      in
        lib.genAttrs appIds (_: {inherit launchOptions;});
    };
  };
}
