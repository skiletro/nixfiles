{
  ...
}: {
  imports = [
    ./general
    ./wms
    ./apps
  ];

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
