{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.desktop.imports = lib.singleton inputs.self.modules.nixos.home;
}
