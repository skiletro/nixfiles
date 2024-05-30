{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.customConfig.gaming.minecraft.enable {
    home = {
      # file.".local/share/PrismLauncher/themes/mocha" = {
      #   source = pkgs.fetchzip {
      #     url = "https://raw.githubusercontent.com/catppuccin/prismlauncher/main/themes/Mocha/Catppuccin-Mocha.zip";
      #     sha256 = "8uRqCoe9iSIwNnK13d6S4XSX945g88mVyoY+LZSPBtQ=";
      #   };
      #   recursive = true;
      # };

      packages = with pkgs; [
        (pkgs.prismlauncher.override {
          jdks = with pkgs; [
            # Java 8
            temurin-jre-bin-8
            # Java 11
            temurin-jre-bin-11
            # Java 17
            temurin-jre-bin-17
            # Latest
            temurin-jre-bin-21
          ];
        })
      ];
    };
  };
}
