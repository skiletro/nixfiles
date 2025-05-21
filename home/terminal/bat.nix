{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    programs.bat.enable = true;
    programs.fish.shellAbbrs.cat = "bat";
  };
}
