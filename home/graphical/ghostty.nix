{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.eos.system.desktop == "gnome") {
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
