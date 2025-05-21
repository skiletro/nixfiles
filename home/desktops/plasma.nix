{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.eos.system.desktop == "plasma") {
    stylix.iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme.override {
        color = "violet";
      };
      dark = "Papirus";
      light = "Papirus";
    };

    dconf = {
      enable = true;
      settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
    };
  };
}
