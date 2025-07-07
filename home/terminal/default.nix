{
  lib,
  osConfig,
  pkgs,
  inputs',
  ...
}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./eos-cli.nix
    ./eza.nix
    ./fastfetch.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./starship.nix
    ./tmux.nix
  ];

  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    home.packages =
      (with pkgs; [
        alejandra # Nix linter
        du-dust # Fancier Looking `du`
        fd # Find files
        file # Identify files
        fzf # Fuzzy-finder
        git # You know what git is
        jq # JSON script processor
        just # Handy way to save and run project-specific commands
        libnotify # Send notifications through scripts, handy to have
        neovim # Vim fork
        ngrok # Reverse proxy
        outfieldr # Tldr client written in Zig
        pamixer # PulseAudio command line mixer
        playerctl # Controls media players
        ripgrep # Grep through files
        tmux # Terminal multiplexer
        unrar # RAR utility
        unzip # ZIP utility
        wget # Get files from command-line
        wineWowPackages.stable # Run Windows apps
      ])
      ++ [inputs'.agenix.packages.default];
  };
}
