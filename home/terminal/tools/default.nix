{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./bat
    ./btop
    ./eza
    ./fastfetch
    ./git
    ./zellij

    ./graphical.nix # Apps that rely on there being a non-headless system
  ];

  home.packages = with pkgs; [
    # Runtimes
    python311
    nodejs_18
    jre_minimal

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
}
