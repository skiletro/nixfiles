{ config, pkgs, lib, inputs, ... }:

{

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = { # not every setting is applied correctly for some reason
      screenshots = true;
      clock = true;
      text-color = "CBA6F7";
      text-ver-color = "cba6f7";
      text-clear-color = "cba6f7";
      text-wrong-color = "cba6f7";
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      effect-blur = "5x7";
      effect-vignette = "0.5:0.5";
      ring-color = "1e1e2e";
      ring-ver-color = "1e1e2e";
      ring-clear-color = "cba6f7";
      ring-wrong-color = "f38ba8";
      bs-hl-color = "f38ba8";
      key-hl-color = "cba6f7";
      font = "Iosevka";
      line-color = "00000000";
      line-ver-color = "00000000";
      line-clear-color = "00000000";
      line-wrong-color = "00000000";
      inside-color = "00000088";
      inside-ver-color = "00000088";
      inside-clear-color = "00000088";
      inside-wrong-color = "00000088";
      seperator-color = "00000000";
      fade-in = 0;
      timestr = "%I:%M%p";
      datestr = "%b %d, %Y";
      ignore-empty-password = true; 
    };
  };

}
