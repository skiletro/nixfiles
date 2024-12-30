{
  lib,
  osConfig,
  inputs,
  ...
}: {
  config = lib.mkIf (osConfig.userConfig.desktop.terminalEmulator == "ghostty") {
    home.packages = [inputs.ghostty.packages.x86_64-linux.default];
  };
}
