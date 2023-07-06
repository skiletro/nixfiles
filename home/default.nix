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

  
  home.packages = with pkgs; [
    direnv
    git
    gh
    wget
    firefox
    kitty
    freshfetch
    swaybg
    nvchad
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
