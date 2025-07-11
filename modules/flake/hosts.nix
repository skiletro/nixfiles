{
  lib,
  inputs,
  self,
  withSystem,
  ...
}: let
  hosts = {
    eris = "x86_64-linux";
    phrixus = "x86_64-linux";
  };

  mkSystem = hostName: system:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs self;};

      modules = [
        inputs.agenix.nixosModules.default
        inputs.chaotic.nixosModules.default
        inputs.determinate.nixosModules.default
        inputs.home-manager.nixosModules.default
        inputs.nur.modules.nixos.default
        inputs.stylix.nixosModules.stylix
        (inputs.import-tree [
          (self + /modules/nixos)
          (self + /modules/pc)
          (self + /hosts/${hostName})
        ])
        {
          _module.args = withSystem system (
            {
              self',
              inputs',
              ...
            }: {
              inherit self' inputs';
            }
          );
        }
        {
          networking = {inherit hostName;};
          nixpkgs.hostPlatform = {inherit system;};
        }
      ];
    };
in {
  flake.nixosConfigurations = lib.mapAttrs mkSystem hosts;
}
