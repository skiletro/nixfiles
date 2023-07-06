{ config, pkgs, lib, inputs, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
  };
  #xdg.configFile."nvim" = { source = "${pkgs.nvchad}"; };

}
