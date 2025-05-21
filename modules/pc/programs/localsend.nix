{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.eos.programs.graphical.enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
