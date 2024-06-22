{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.terminal.utils.enable {
    home.packages = with pkgs; [
      # Misc.
      htop
      wget
      unzip
      unrar
      jq
      socat
      ripgrep
      libnotify
      glib
      acpi
      wl-clipboard
      fzf
      lutgen
      cmake
      gnumake
      fd
      imagemagick
      just
      du-dust
      tldr
    ];
  };
}
