{ config, pkgs, lib, inputs, ... }:

{
    home.username = "jamie";
    home.homeDirectory = "/home/jamie";
    home.packages = with pkgs; [
      firefox
      kitty
      neofetch
      git
      wget
      swaybg
    ];
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disables the greeting
	      starship init fish | source # Enables starship
      '';
    };

    programs.starship = {
      enable = true;
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
    };
    #xdg.configFile."nvim" = { source = "${pkgs.nvchad}"; }; 

}
