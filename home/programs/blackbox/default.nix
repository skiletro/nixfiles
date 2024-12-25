{
  lib,
  osConfig,
  pkgs,
  ...
}:
with lib.hm.gvariant; {
  config = lib.mkIf (osConfig.userConfig.desktop.terminalEmulator == "blackbox") {
    home.packages = with pkgs; [blackbox-terminal];

    dconf.settings = {
      "com/raggesilver/BlackBox" = {
        context-aware-header-bar = false;
        floating-controls = true;
        font = "${osConfig.stylix.fonts.monospace.name} 11";
        headerbar-drag-area = false;
        notify-process-completion = false;
        pretty = false;
        remember-window-size = true;
        show-menu-button = true;
        style-preference = mkUint32 2;
        terminal-cell-width = 1.0;
        terminal-padding = mkTuple [(mkUint32 10) (mkUint32 10) (mkUint32 10) (mkUint32 10)];
        theme-bold-is-bright = false;
        theme-dark = "Adwaita Dark";
        was-fullscreened = false;
        was-maximized = false;
        window-height = mkUint32 771;
        window-width = mkUint32 1091;
        working-directory-mode = mkUint32 1;
      };
    };
  };
}
