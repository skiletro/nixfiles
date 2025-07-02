{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.eos.tooling.python.enable {
    home.packages = with pkgs; [
      python313
      python313Packages.jedi-language-server
    ];
  };
}
