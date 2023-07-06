{ config, pkgs, lib, inputs, ... }:

{

  #services.xserver.enable = true;
  #services.xserver.displayManager.sddm.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      bind = SUPER, Return, exec, kitty
      exec-once = swaybg -c ff00aa
    '';
  };

}
