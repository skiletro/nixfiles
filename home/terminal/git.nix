{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    # See https://github.com/uncenter/flake/blob/main/user/programs/git.nix for some options you can steal >:P
    programs = {
      git = {
        enable = true;
        userName = "skiletro";
        userEmail = "19377854+skiletro@users.noreply.github.com";
        difftastic.enable = true;
      };

      lazygit.enable = true;
      fish.shellAbbrs.lg = "lazygit";
    };
  };
}
