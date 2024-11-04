{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = {
    programs.eza = {
      enable = true;
      icons = "auto";
    };
  };
}
