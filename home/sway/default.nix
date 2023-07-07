{ config, pkgs, lib, inputs, ... }:

{

  #services.xserver.enable = true;
  #services.xserver.displayManager.sddm.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      env = WLR_NO_HARDWARE_CURSORS, 1
      env = WLR_RENDERER_ALLOW_SOFTWARE, 1
      bind = SUPER, Return, exec, kitty
      exec-once = swaybg -c ff00aa
    '';
  };

}
