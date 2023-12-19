{...}: {
  imports = [
    ./config
    ./graphical
    ./services
    ./terminal
  ];

  home = {
    username = "jamie";
    homeDirectory = "/home/jamie";
  };

  # fonts work when this is enabled :shrug:
  fonts.fontconfig.enable = true;

  home.stateVersion = "23.05"; # check wiki before updating this!!!

  programs.home-manager.enable = true;
}
