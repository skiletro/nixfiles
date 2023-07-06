{ config, pkgs, lib, inputs, ... }:

{
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disables the greeting
        direnv hook fish | source # 
        starship init fish | source # Enables starship
      '';
    };
}
