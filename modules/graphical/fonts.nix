{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf (config.userConfig.system.gpu != "none") {
    fonts = {
      fontDir.enable = true;

      packages = with pkgs; [
        corefonts # Microsoft Fonts
        vistafonts # More Microsoft Fonts
        noto-fonts
        noto-fonts-extra
        noto-fonts-cjk-sans # Japanese, Korean, Chinese, etc
        noto-fonts-color-emoji
        nerd-fonts.symbols-only
        nerd-fonts."m+"
        nur.repos.skiletro.urbanist
        nur.repos.skiletro.gabarito
      ];
    };
  };
}
