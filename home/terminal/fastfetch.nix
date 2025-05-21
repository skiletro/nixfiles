{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    programs.fastfetch.enable = true;
    programs.fish.shellAbbrs.neofetch = "fastfetch";
  };
}
