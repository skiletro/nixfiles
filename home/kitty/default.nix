{ config, pkgs, lib, inputs, ... }:

{
  programs.kitty = {
    enable = false;
    theme = "Catppuccin-Mocha";
    settings = {
      font_family = "Iosevka Comfy";
      window_padding_width = 15;
    };
  };
}
