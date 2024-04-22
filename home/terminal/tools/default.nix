{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./bat
    ./btop
    ./fastfetch
    ./montool
    ./zellij
  ];

  home.packages = with pkgs; [
    wget
    unzip
    unrar
    jq
    socat
    ripgrep
    swww
    htop
    tmux
    onedrive
    playerctl
    brightnessctl
    pamixer
    libnotify
    glib
    upower
    acpi
    wlsunset
    cava
    sway-contrib.grimshot #screenshots
    wl-clipboard
    wtype
    fzf
    python311
    nodejs_18
    jre_minimal
    nix-index
    nix-prefetch
    distrobox
    podman
    lutgen
    cmake
    gnumake
    fd
    imagemagick
    just
  ];
}
