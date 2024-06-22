{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.graphical.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacsWithPackagesFromUsePackage {
        package =
          if osConfig.userConfig.desktop.isWayland
          then pkgs.emacs29-pgtk
          else pkgs.emacs; # X11 fallback
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
