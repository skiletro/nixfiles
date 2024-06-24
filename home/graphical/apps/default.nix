{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./emacs
    ./firefox
    ./mpv
    ./spotify
    ./vscode
    ./zathura
  ];

  config = lib.mkIf osConfig.userConfig.programs.graphical.enable {
    home.packages = with pkgs; [
      xorg.xeyes #used literally just to test if app is xorg
      tenacity
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
      ungoogled-chromium
      element-desktop
      vial
      gnome.file-roller # GUI zip tool
      pavucontrol
      gnome.gnome-font-viewer
      inkscape
      qdirstat
      usbimager
      fusee-interfacee-tk # Graphical Switch RCM Tool
      qbittorrent
      vesktop # Discord
    ];
  };
}
