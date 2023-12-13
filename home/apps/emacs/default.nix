{pkgs, ...}: let
  emacs-pkg = pkgs.emacs29-pgtk;
in {
  # For doom emacs to work, you'll need to clone the repo as per the instructions in the doomemacs/doomemacs repo
  programs.emacs = {
    enable = true;
    package = emacs-pkg;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  xdg.configFile.".doom.d" = {
    target = "../.doom.d";
    source = ./doom.d;
    recursive = true;
    #onChange = "${pkgs.libnotify}/bin/notify-send -u critical 'DOOM EMACS' 'Changed detected when rebuilding system. Please make sure to run `doom sync`!'";
  };

  home.packages = let
    magit-script = pkgs.writeShellScriptBin "magit" ''
      if [[ -d "./.git" ]]; then
        ${emacs-pkg}/bin/emacs -nw --eval "(progn (magit-status) (delete-other-windows))"
      else
        echo "Err: Not a git repo" >>/dev/stderr
      fi
    '';
  in
    with pkgs; [
      magit-script #^^
      rust-analyzer #rust lsp
      nodePackages.bash-language-server #sh and bash
      zls #zig lsp
      rnix-lsp #nix lsp
      ccls # c and c++ lsp
      texlive.combined.scheme-medium #latex
      pandoc #document conversion
      gnuplot
      graphviz #org roam graph generation
      nodePackages_latest.pyright # python lsp
    ];
}
