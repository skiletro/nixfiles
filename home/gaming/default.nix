{
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./vr.nix
  ];

  config = lib.mkIf osConfig.eos.programs.gaming.enable {
    stylix.targets.mangohud.enable = false;

    programs.mangohud = {
      enable = true;
      enableSessionWide = false; # Need to test to see if it crashes gamescope with workaround implem.
    };
  };
}
