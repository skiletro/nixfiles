{inputs, ...}: {
  flake.modules.nixos.nixos = {
    imports = with inputs; [
      determinate.nixosModules.default
      nur.modules.nixos.default
    ];
  };
}
