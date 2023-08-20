{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      ${builtins.readFile ./autolaunch.conf}
      ${builtins.readFile ./appearance.conf}
      ${builtins.readFile ./input.conf}
      ${builtins.readFile ./binds.conf}
      ${builtins.readFile ./misc.conf}
    '';
  };
}
