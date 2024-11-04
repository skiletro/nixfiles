{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}: {
  imports = [
    ./launchers.nix
    ./vr.nix
  ];
}
