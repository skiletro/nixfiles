{ config, pkgs, lib, inputs, ... }:

{
    home.username = "jamie";
    home.homeDirectory = "/home/jamie";
    home.packages = with pkgs; [
      direnv
      git
      gh
      wget
      firefox
      kitty
      foot #tmp
      neofetch
      swaybg
    ];

    programs.starship = {
      enable = true;
    };

}
