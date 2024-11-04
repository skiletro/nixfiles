{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = {
    programs.bat.enable = true;

    programs.fish.shellAbbrs = {
      cat = "bat";
    };
  };
}
