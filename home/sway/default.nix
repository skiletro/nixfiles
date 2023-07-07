{ config, pkgs, lib, inputs, ... }:

{

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "foot";
    };
  };

}
