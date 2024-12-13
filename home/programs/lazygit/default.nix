{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.lazygit.enable {
    programs.lazygit.enable = true;
    # This file seems pretty pointless so far, but in case I want any custom settings in the future, it lets me add them a lot easier.
  };
}
