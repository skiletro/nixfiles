{ config, pkgs, lib, inputs, ... }:

{

  imports = [
    # Users
    ./jamie

    # Window Managers
    ./hyprland

    # Programs
    ./fish
    ./starship
    ./foot
    ./neovim
    ./vscode
    ./eww
  ];

  
  home.packages = with pkgs; [
    # cli
    direnv
    git
    gh
    wget
    unzip
    unrar
    jq
    socat
    freshfetch
    swaybg

    #gui
    firefox
    kitty
    #nvchad #god knows what's going on with this rn
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
