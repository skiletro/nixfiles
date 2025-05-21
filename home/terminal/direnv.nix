{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true; # faster implementation
      silent = true;
    };
  };
}
