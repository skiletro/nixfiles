{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./bat
    ./eza
    ./fastfetch
    ./git
    ./zellij

    ./extras.nix
    ./utils.nix
    ./graphical.nix # Apps that rely on there being a non-headless system
  ];
}
