{ config, pkgs, lib, inputs, ... }:

{

  imports = [
    # Users
    ./jamie

    # Window Managers
    ./hyprland
    ./sway

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
    ripgrep
    freshfetch
    swaybg
    htop
    btop #better htop but is a bit more cluttered
    tmux

    #gui
    firefox
    kitty
    beeper
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
