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

      shellAbbrs.n = "cd ~/.nix_config/";
    };
  };
}
