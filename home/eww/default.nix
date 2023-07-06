{ config, pkgs, lib, inputs, ... }:

{

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = "./config";
  }

}