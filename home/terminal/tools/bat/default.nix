{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.terminal.utils.enable {
    programs.bat = {
      # FIXME
      enable = true;
    };

    programs.fish.shellAbbrs = {
      cat = "bat";
    };
  };
}
