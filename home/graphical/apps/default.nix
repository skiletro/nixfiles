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
    beeper
    thunderbird
    nomacs
    libreoffice-qt
    obs-studio
    vial
    gnome.file-roller #gui zip tool
    pavucontrol
    mpv
    gnome.gnome-font-viewer
    inkscape
    qdirstat
    usbimager
    fusee-interfacee-tk #switch rcm
    rstudio #uni
  ];
}
