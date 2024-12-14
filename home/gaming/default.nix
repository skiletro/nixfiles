{
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./vr.nix
  ];

  config = lib.mkIf osConfig.userConfig.gaming.enable {
    programs.mangohud = {
      enable = true;
      enableSessionWide = false; # Need to test to see if it crashes gamescope with workaround implem.
    };
  };
}
