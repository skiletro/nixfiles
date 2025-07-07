{
  pkgs,
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    home.packages = [
      (pkgs.writeShellApplication {
        name = "eos";
        runtimeInputs = with pkgs; [nh just];
        text =
          # sh
          ''
            cd ${osConfig.programs.nh.flake}
            exec just "$@"
          '';
      })
    ];
  };
}
