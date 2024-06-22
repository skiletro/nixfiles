{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.terminal.extras.enable {
    home.packages = with pkgs; [
      # Runtimes
      python311
      nodejs_18
      jre_minimal
    ];
  };
}
