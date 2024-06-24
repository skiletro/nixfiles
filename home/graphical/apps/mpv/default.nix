{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.graphical.mpv.enable {
    programs.mpv = {
      enable = true;
      config = {
        geometry = "1250x720-50%-50%";
      };
      scripts = with pkgs.mpvScripts; [
        modernx
      ];
    };
  };
}
