{ config, pkgs, lib, inputs, ... }:

{
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disables the greeting
      '';
    };
}
