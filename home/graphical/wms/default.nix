{...}: {
  imports = [
    ./hyprland

    # Configuration for the window manager(s)
    ./theming.nix
    ./xdg.nix
  ];
}
