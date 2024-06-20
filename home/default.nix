{...}: {
  imports = [
    ./graphical
    ./services
    ./terminal
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

  # fonts work when this is enabled :shrug:
  fonts.fontconfig.enable = true;

  home.stateVersion = "23.05"; # check wiki before updating this!!!

  programs.home-manager.enable = true;
}
