{
  self,
  self',
  inputs,
  inputs',
  pkgs,
  config,
  ...
}: let
  inherit (config.eos.system) user;
in {
  config = {
    home-manager = {
      useGlobalPkgs = true;
      backupFileExtension = "hm";
      users.${user}.imports = [
        {
          imports = [
            inputs.agenix.homeManagerModules.default
            ./stylix.nix
            ./desktops
            ./gaming
            ./graphical
            ./services
            ./terminal
            ./tooling
          ];

          home = {
            username = user;
            homeDirectory = "/home/${user}";
            stateVersion = "23.05";
            shell.enableFishIntegration = true;
          };

          manual = {
            html.enable = false;
            json.enable = false;
            manpages.enable = true;
          };

          fonts.fontconfig.enable = true;

          xdg.enable = true;

          programs.home-manager.enable = true;
        }
      ];
      extraSpecialArgs = {inherit self self' inputs inputs';};
    };

    age.secrets.user-password.file = ../secrets/user-password.age;

    users.users.${user} = {
      isNormalUser = true;
      passwordFile = config.age.secrets.user-password.path;
      extraGroups = ["users" "networkmanager" "wheel" "libvirtd" "gamemode"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnFEMa0S9zuA5cVg+Ktazz9gEevkDCNYIDX0WAMxcAC eos"
      ];
      shell = pkgs.fish;
    };
    programs.fish.enable = true; # This is required otherwise the option above doesn't work.
  };
}
