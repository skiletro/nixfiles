{inputs, ...}: {
  flake.modules.nixos.nixos.imports = [
    inputs.agenix.nixosModules.default
    {age.identityPaths = ["/home/jamie/.ssh/id_ed25519"];}
  ];
  flake.modules.homeManager.jamie.imports = [
    inputs.agenix.homeManagerModules.default
  ];
}
