{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.eos.programs.terminal.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        editor = {
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          indent-guides = {
            character = "‣";
            render = true;
            skip-levels = 1;
          };
          auto-pairs = true;
        };
      };
    };
  };
}
