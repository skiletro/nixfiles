{
  pkgs,
  inputs,
  ...
}: {
  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww.override {
      withWayland = true;
    };
    configDir = ./config;
  };
}
