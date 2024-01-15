{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./bat
    ./btop
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
    neofetch
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
