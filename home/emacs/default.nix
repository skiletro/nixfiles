{pkgs, ...}: {
  # For doom emacs to work, you'll need to clone the repo as per the instructions in the doomemacs/doomemacs repo
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };

  xdg.configFile.".doom.d" = {
    target = "../.doom.d";
    source = ./doom.d;
    recursive = true;
    #onChange = "${pkgs.libnotify}/bin/notify-send -u critical 'DOOM EMACS' 'Changed detected when rebuilding system. Please make sure to run `doom sync`!'";
  };
}
