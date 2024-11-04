{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacsWithPackagesFromUsePackage {
        package =
          if (osConfig.networking.hostname == "wsl")
          then pkgs.emacs # The WSL environment doesn't like PGTK
          else pkgs.emacs29-pgtk;
        config = ./config.org;
        defaultInitFile = true;
        alwaysTangle = true;
        extraEmacsPackages = epkgs: [epkgs.use-package];
        alwaysEnsure = true;
      };
    };

    home.packages = with pkgs; [
      ccls # C++
      pyright # Python
      nil # Nix
    ];
  };
}
