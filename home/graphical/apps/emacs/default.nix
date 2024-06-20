{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.graphical.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacsWithPackagesFromUsePackage {
        package = pkgs.emacs29-pgtk;
        config = ./config.org;
        defaultInitFile = true;
        alwaysTangle = true;
        extraEmacsPackages = epkgs: [epkgs.use-package];
        alwaysEnsure = true;
      };
    };

    home.packages = with pkgs; [
      ccls
      nodePackages.pyright
      nil
    ];
  };
}
