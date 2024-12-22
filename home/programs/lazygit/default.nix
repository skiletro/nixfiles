{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.lazygit.enable {
    programs.lazygit.enable = true;
    programs.fish.shellAbbrs.lg = "lazygit";
  };
}
