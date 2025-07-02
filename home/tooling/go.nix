{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.eos.tooling.go.enable {
    home.packages = with pkgs; [
      go
      gopls
    ];
  };
}
