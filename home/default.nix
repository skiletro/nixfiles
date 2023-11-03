{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./general
    ./desktops
    ./programs
  ];

  nixpkgs.overlays = [
    inputs.nur.overlay
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
