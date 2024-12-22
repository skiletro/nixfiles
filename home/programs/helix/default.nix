{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.userConfig.programs.helix.enable {
    programs.helix = {
      enable = true;
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
        };
      };
    };
  };
}
