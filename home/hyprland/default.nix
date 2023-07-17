{ config, pkgs, lib, inputs, ... }:

{

  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages.${pkgs.system}.hyprland-hidpi;
    enable = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
    nvidiaPatches = false;
    plugins = [
      #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];

    extraConfig = ''
      ${builtins.readFile ./autolaunch.conf}
      ${builtins.readFile ./appearance.conf}
      ${builtins.readFile ./input.conf}
      ${builtins.readFile ./binds.conf}
      ${builtins.readFile ./misc.conf}
    '';
  };

}
