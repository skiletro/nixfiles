{ config, pkgs, lib, inputs, ... }:

{

  imports = [
    # Users
    ./jamie

    # Window Managers
    ./hyprland

    # Programs
    ./foot
    ./neovim
    ./vscode
    ./fish
    ./starship
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
