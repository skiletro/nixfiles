{pkgs, ...}: {
  imports = [
    ./discord
    ./emacs
    ./firefox
    ./spotify
    ./vscode
    ./zathura
  ];

  home.packages = with pkgs; [
    xorg.xeyes #used literally just to test if app is xorg
    gnome.nautilus
    (beeper.overrideAttrs (old: {
      installPhase =
        (old.installPhase or "")
        + ''
          wrapProgram $out/bin/beeper --add-flags "--default-frame"
        '';
    }))
    thunderbird
    nomacs
    (libreoffice-qt.overrideAttrs {
      propagatedBuildInputs = with pkgs; [
        jre_minimal
        hunspell
        hunspellDicts.en_GB-ise
      ];
    })
    obs-studio
    obsidian
    teams-for-linux
    vial
    gnome.file-roller #gui zip tool
    pavucontrol
    mpv
    gnome.gnome-font-viewer
    inkscape
    qdirstat
    usbimager
    fusee-interfacee-tk #switch rcm
    zotero
    rstudio #uni
  ];
}
