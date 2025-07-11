{
  inputs,
  lib,
  ...
}: {
  flake.lib.mkSystem = system: class: hostname:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        inputs.self.modules.nixos.nixos
        inputs.self.modules.nixos.${class}
        # inputs.self.modules.nixos.${hostname}
        {
          networking.hostName = lib.mkDefault hostname;
          nixpkgs.hostPlatform = lib.mkDefault system;
          system.stateVersion = "25.11";
        }
      ];
    };
}
