{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf (!config.userConfig.isHeadless) {
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
        nerd-fonts.mplus
        nur.repos.skiletro.urbanist
        nur.repos.skiletro.gabarito
      ];
    };
  };
}
