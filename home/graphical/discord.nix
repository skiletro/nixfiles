{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.enable {
    home.packages = [(pkgs.discord.override {withVencord = true;})];
  };
}
