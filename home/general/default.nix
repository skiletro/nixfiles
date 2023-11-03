{...}: {
  home.username = "jamie";
  home.homeDirectory = "/home/jamie";

  imports = [
    ./themes
    ./xdg
  ];

  fonts.fontconfig.enable = true;
}
