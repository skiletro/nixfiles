{
  lib,
  config,
  ...
}: {
  options.userConfig.programs.localsend.enable = lib.mkEnableOption "LocalSend";

  config = lib.mkIf config.userConfig.programs.localsend.enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
