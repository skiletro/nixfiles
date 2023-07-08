{ config, pkgs, lib, inputs, ... }:

{

  programs.eww = {
    enable = true;
    package = pkgs.eww-systray;
    configDir = ./config;
  };

}