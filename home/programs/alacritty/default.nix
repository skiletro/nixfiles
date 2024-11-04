{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.userConfig.desktop.terminalEmulator == "alacritty") {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 10;
            y = 10;
          };
          dynamic_padding = true;
        };
        env = {
          TERM = "xterm-256color";
        };
      };
    };
  };
}
