{
  self,
  self',
  inputs,
  inputs',
  pkgs,
  ...
}: {
  config = {
    home-manager = {
      useGlobalPkgs = true;
      backupFileExtension = "hm";
      users.jamie.imports = [
        {
          imports = [
            ./desktops
            ./gaming
            ./graphical
            ./terminal
            ./tooling
          ];

          home = {
            username = "jamie";
            homeDirectory = "/home/jamie";
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

    users.users.jamie = {
      isNormalUser = true;
      extraGroups = ["users" "networkmanager" "wheel" "libvirtd"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnFEMa0S9zuA5cVg+Ktazz9gEevkDCNYIDX0WAMxcAC eos"
      ];
      shell = pkgs.fish;
    };
    programs.fish.enable = true; # This is required otherwise the option above doesn't work.
  };
}
