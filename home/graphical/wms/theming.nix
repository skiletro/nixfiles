{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cursor_name = "macOS-Monterey";
  cursor_pkg = pkgs.apple-cursor;
in {
  config = lib.mkIf osConfig.userConfig.services.theming.enable {
    gtk = {
      enable = true;

      iconTheme.package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
      iconTheme.name = "Papirus-Dark";

      theme.package = pkgs.catppuccin-gtk.override {
        accents = ["mauve"];
        size = "standard";
        tweaks = ["rimless"];
        variant = "mocha";
      };
      theme.name = "Catppuccin-Mocha-Standard-Mauve-Dark";

      cursorTheme.name = cursor_name;
      cursorTheme.package = cursor_pkg;
      cursorTheme.size = 24;

      font.name = "Iosevka Comfy";
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk";
    };

    home.pointerCursor = {
      name = cursor_name;
      package = cursor_pkg;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    dconf.settings = {
      # gsettings set org.gnome.desktop.wm.preferences button-layout :
      "org/gnome/desktop/wm/preferences".button-layout = "''";
    };
  };
}
