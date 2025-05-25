{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.eos.system.desktop == "plasma") {
    dconf = {
      enable = true;
      settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
    };
  };
}
