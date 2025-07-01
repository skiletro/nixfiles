{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.eos.tooling.rust.enable {
    home.packages = with pkgs; [
      rust-analyzer
      rustfmt
      clippy
    ];
  };
}
