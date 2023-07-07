{ config, pkgs, lib, inputs, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    #extraConfig = lib.fileContents ./config/init.lua;
    extraPackages = with pkgs; [
      gcc
    ];
  };
  #xdg.configFile."nvim" = { source = "${pkgs.vimPlugins.nvchad}"; };
  xdg.configFile."nvim" = { source = "${pkgs.nvchad}"; };

}
