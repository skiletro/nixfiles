{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.eos.tooling.nix.enable {
    home.packages = with pkgs; [
      alejandra
      deadnix
      nil
    ];
  };
}
