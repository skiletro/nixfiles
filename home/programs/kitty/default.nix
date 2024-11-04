{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.userConfig.desktop.terminalEmulator == "kitty") {
    programs.kitty = {
      enable = true;
      settings = {
        window_padding_width = 10;
      };
    };
  };
}
