{pkgs, ...}: {
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
    theme.name = "Catppuccin-Mocha-Standard-Mauve-dark";

    cursorTheme.package = pkgs.catppuccin-cursors.mochaDark;
    cursorTheme.name = "Catppuccin-Mocha-Dark-Cursors";
    cursorTheme.size = 24;

    font.name = "Iosevka Comfy";
  };

  #---qt themeing
  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "Mauve";
      variant = "Mocha";
    })
  ];

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "Catppucin-Mocha-Mauve";
  };
  #---end of qt theming

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/wm/preferences".button-layout = "''"; # Hides top-bar buttons
  };
}
