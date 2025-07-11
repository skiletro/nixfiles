{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.home = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = [inputs.home-manager.nixosModules.default];

    users.users.jamie = {
      isNormalUser = true;
      initialPassword = "";
      passwordFile = config.age.secrets.user-password.path;
      extraGroups = ["users" "networkmanager" "wheel" "libvirtd" "gamemode"]; # TODO: get rid of these extra groups into their own files
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnFEMa0S9zuA5cVg+Ktazz9gEevkDCNYIDX0WAMxcAC eos"
      ];
      shell = pkgs.fish;
    };

    programs.fish.enable = true;

    age.secrets.user-password.file = self + "/secrets/user-password.age";

    services.displayManager.autoLogin = lib.mkIf config.services.displayManager.enable {
      enable = true;
      user = "jamie";
    };

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services = lib.mkIf config.services.displayManager.enable {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };

    home-manager.users.jamie = {
      imports = lib.singleton inputs.self.modules.homeManager.jamie;

      home = {
        username = "jamie";
        homeDirectory = "/home/jamie";
        inherit (config.system) stateVersion;
      };
    };
  };
}
