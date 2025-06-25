{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf (osConfig.eos.system.desktop == "plasma") {
    stylix.iconTheme = {
      enable = true;
      package = pkgs.colloid-icon-theme;
      dark = "Colloid-Dark";
      light = "Colloid-Light";
    };

    dconf = {
      enable = true;
      settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
    };
  };
}
