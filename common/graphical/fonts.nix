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
        (nerdfonts.override {
          fonts = [
            "MPlus"
            "NerdFontsSymbolsOnly"
          ];
        })
        iosevka-comfy.comfy
        nur.repos.skiletro.urbanist
        nur.repos.skiletro.gabarito
      ];
    };
  };
}
