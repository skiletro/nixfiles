{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.graphical.gaming.minecraft.enable {
    home = {
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
