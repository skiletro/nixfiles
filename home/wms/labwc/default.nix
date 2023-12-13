{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    labwc
    sfwbar #temp bar
    numix-gtk-theme #temp theme (better than default)
  ];

  #TODO: Finish configuration files and nixify (basically just put here)
}
