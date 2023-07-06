{ config, pkgs, lib, inputs, ... }:

{

  imports = [
    # Users
    ./jamie

    # Window Managers
    ./hyprland

    # Programs
    ./neovim
    ./vscode
    ./fish
    ./starship
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
