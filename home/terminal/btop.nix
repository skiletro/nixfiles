{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = let
    inherit (osConfig.eos.system) gpu;
  in
    lib.mkIf osConfig.eos.programs.terminal.enable {
      programs.btop = {
        enable = true;
        package = with pkgs;
          if gpu == "nvidia"
          then btop-cuda
          else if gpu == "amd"
          then btop-rocm
          else btop;
      };
    };
}
