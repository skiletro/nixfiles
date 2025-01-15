{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (builtins.elem "plasma" osConfig.userConfig.desktop.environments) {
    dconf = {
      enable = true;
      settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
    };
  };
}
