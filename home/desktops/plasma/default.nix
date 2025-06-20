{
  lib,
  osConfig,
  inputs,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager

    ./panels.nix
    ./shortcuts.nix
  ];

  config = lib.mkIf (osConfig.eos.system.desktop == "plasma") {
    programs.plasma = {
      enable = true;
    };

    dconf = {
      enable = true;
      settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
    };
  };
}
