{
  lib,
  pkgs,
  osConfig,
  ...
}: {
  imports = [
    ./prismlauncher
    ./steam
  ];

  config = lib.mkIf osConfig.userConfig.programs.graphical.gaming.enable {
    home.packages = with pkgs; [
      # Tools
      gamescope
      protonup-qt #modify steam proton versions
      parsec-bin

      # Launchers
      lutris #non-steam games that need extra tweaking
      bottles #same idea as lutris
      heroic #epic games & gog - disabled due to security (electron)
    ];

    programs.mangohud = {
      enable = true;
      enableSessionWide = false; # Need to test to see if it crashes gamescope with workaround implem.
      # TODO: Need to customise more
    };
  };
}
