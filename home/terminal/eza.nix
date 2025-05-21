{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    programs.eza = {
      enable = true;
      icons = "auto";
    };
  };
}
