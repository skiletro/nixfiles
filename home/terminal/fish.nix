{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    # https://github.com/uncenter/flake/blob/main/user/shells/fish.nix
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';

      plugins = [
        {
          name = "done";
          src = pkgs.fetchFromGitHub {
            owner = "franciscolourenco";
            repo = "done";
            rev = "d47f4d6551cccb0e46edfb14213ca0097ee22f9a";
            sha256 = "sha256-VSCYsGjNPSFIZSdLrkc7TU7qyPVm8UupOoav5UqXPMk=";
          };
        }
      ];

      functions = {
        "," =
          # fish
          ''
            NIXPKGS_ALLOW_UNFREE=1 nix run "nixpkgs#$argv[1]" --impure -- $argv[2..-1]
          '';

        "process_replays" =
          # fish
          ''
            for file in Replay_*.mp4
              set output Processed_$file
              ffmpeg -i $file $output
            end
          '';
      };

      shellAbbrs.n = "cd ~/.nix_config/";
    };
  };
}
