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
    thunderbird
    gnome.eog
    (libreoffice-qt.overrideAttrs {
      propagatedBuildInputs = with pkgs; [
        hunspell
        hunspellDicts.en_GB-ise
      ];
    })
    obs-studio
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
    qbittorrent
    mission-center
  ];
}
