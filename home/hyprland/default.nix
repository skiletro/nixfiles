{
  config,
  pkgs,
  lib,
  inputs,
  osConfig,
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
      ${lib.optionalString (osConfig.networking.hostName == "themis") builtins.readFile ./themis.conf}
    '';
  };
}
