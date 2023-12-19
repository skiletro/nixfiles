{pkgs, ...}: let
  catppuccin-mocha = pkgs.fetchzip {
    url = "https://raw.githubusercontent.com/catppuccin/prismlauncher/main/themes/Mocha/Catppuccin-Mocha.zip";
    sha256 = "8uRqCoe9iSIwNnK13d6S4XSX945g88mVyoY+LZSPBtQ=";
  };

  java_packages = with pkgs; [
    # Java 8
    temurin-jre-bin-8
    zulu8
    # Java 11
    temurin-jre-bin-11
    # Java 17
    #temurin-jre-bin-17
    # Latest
    #temurin-jre-bin
    #zulu
    #graalvm-ce
  ];
in {
  home = {
    file.".local/share/PrismLauncher/themes/mocha" = {
      source = catppuccin-mocha;
      recursive = true;
    };

    packages = with pkgs; [
      (pkgs.prismlauncher.override {
        jdks = java_packages;
      })
    ];
  };
}
