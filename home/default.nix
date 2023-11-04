{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./general
    ./wms
    ./apps
  ];

  nixpkgs.overlays = [
    inputs.nur.overlay
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
