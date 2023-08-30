{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
  };
}
