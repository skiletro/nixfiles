{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.jamie = {
    isNormalUser = true;
    description = "Jamie";
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAgrRSnsFyg9ru8G1v+u6G7muahe3N5nDmUpInhMcXrABogdzvPBxo4PFEWpARxAmUOyjvKromYmw8ClfVYWi5cwEko1jeQNBMvhLb8bax78dzVz8rmP6pksWib0pGEICa6N52XgJhJZjcZqX/7Oi6NmFqF575TDI8NOE47vf5bMVPoPQ20j/6C3Jtrrpbr7DEHCp6DwiG71UQKNbIJc3xnxKNqQ7mg/w3Be/I8niDJfZII9J0/iuxtwMsYxwdj0rvDbVrztcoGW2u5rb9H2QiIkf1X6eyUlSMWqJ1szCW2sVVOfXsS5GLtqT9nryDR2rY1eeYk6EsLzogiLk9bq4/4w== skil19"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnFEMa0S9zuA5cVg+Ktazz9gEevkDCNYIDX0WAMxcAC eos"
    ];
  };
  programs.fish.enable = true;
  programs.starship.enable = true;

  # Bare minimum programs needed on all systems
  environment.systemPackages = with pkgs; [
    alejandra
    gh
    direnv
    git
    neovim
  ];

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}
