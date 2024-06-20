{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.graphical.enable {
    programs.kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      settings = {
        font_family = "Iosevka Comfy";
        window_padding_width = 10;
      };
    };
  };
}
