{pkgs, ...}: {
  config = let
    emacs-pkg = pkgs.emacs29-pgtk;
  in {
    programs.emacs = {
      enable = true;
      package = pkgs.emacsWithPackagesFromUsePackage {
        package = emacs-pkg;
        config = ./config.org;
        defaultInitFile = true;
        alwaysTangle = true;
        extraEmacsPackages = epkgs: [epkgs.use-package];
        alwaysEnsure = true;
      };
    };
  };
}
