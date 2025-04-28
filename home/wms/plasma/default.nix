{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf (builtins.elem "plasma" osConfig.userConfig.desktop.environments) {
    stylix.iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme.override {
        color = "red";
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
