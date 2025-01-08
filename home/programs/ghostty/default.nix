{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.userConfig.desktop.terminalEmulator == "ghostty") {
    programs.ghostty = {
      enable = true;
      settings = let
        padding = 6;
      in {
        adjust-cell-width = "-1";
        window-padding-x = padding;
        window-padding-y = padding;
      };
    };
  };
}
