{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.graphical.zathura.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
