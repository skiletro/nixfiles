{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.gaming.enable {
    # CS2
    xdg.dataFile."Steam/steamapps/common/Counter-Strike Global Offensive/game/csgo/cfg/autoexec.cfg".source = ./cs2.cfg;
  };
}
