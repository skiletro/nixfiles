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
    theme.name = "Catppuccin-Mocha-Standard-Mauve-Dark";

    cursorTheme.package = pkgs.catppuccin-cursors.mochaDark;
    cursorTheme.name = "Catppuccin-Mocha-Dark-Cursors";
    cursorTheme.size = 24;

    font.name = "Iosevka Comfy";
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Hides the close button on gnome apps
  dconf.settings = {
    "org/gnome/desktop/wm/preferences".button-layout = "''";
  };
}
