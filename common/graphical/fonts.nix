{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    userConfig.programs.graphical.fonts.enable = lib.mkOption {
      default =
        if config.userConfig.programs.graphical.enable
        then true
        else false;
      description = "Enables fonts";
    };
  };

  config = lib.mkIf config.userConfig.programs.graphical.fonts.enable {
    fonts = {
      fontDir.enable = true;

      packages = with pkgs; [
        corefonts # Microsoft Fonts
        vistafonts # More Microsoft Fonts
        noto-fonts
        noto-fonts-extra
        noto-fonts-cjk # Japanese, Korean, Chinese, etc
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

      fontconfig = {
        enable = true;
        localConf = ''
          <match target="pattern">
            <test qual="any" name="family" compare="eq"><string>Iosevka Comfy</string></test>
            <edit name="family" mode="assign" binding="same"><string>SymbolsNerdFont</string></edit>
          </match>
        '';
        defaultFonts = {
          monospace = ["Iosevka Comfy" "SymbolsNerdFont" "Noto Color Emoji"];
          sansSerif = ["Urbanist" "Noto Sans" "Noto Fonts Extra"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };
  };
}
