{
  imports = [
    ./gaming
    ./programs
    ./services
    ./wms
  ];

  home = {
    username = "jamie";
    homeDirectory = "/home/jamie";
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = true;
  };

  fonts.fontconfig.enable = true; # fonts work when this is enabled :shrug:

  home.stateVersion = "23.05"; # check wiki before updating this!!!

  programs.home-manager.enable = true;
}
