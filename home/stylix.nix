{pkgs, ...}: {
  # Icon Themes
  stylix.iconTheme = {
    enable = true;
    package = pkgs.papirus-icon-theme.override {
      color = "violet"; # This matches the wallpapers general colour scheme. Change as required.
    };
    dark = "Papirus";
    light = "Papirus";
  };
}
