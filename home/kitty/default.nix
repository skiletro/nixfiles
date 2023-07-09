{ config, pkgs, lib, inputs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    settings = {
      font_family = "Iosevka Eos";
      window_padding_width = 15;
    };
  };
}
