{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (builtins.elem "gnome" osConfig.userConfig.desktop.environments) {
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/mutter".experimental-features = ["scale-monitor-framebuffer" "variable-refresh-rate"];
    };
  };
}
