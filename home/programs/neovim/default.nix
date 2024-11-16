{
  config,
  inputs,
  lib,
  osConfig,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];

  config = lib.mkIf osConfig.userConfig.programs.neovim.enable {
    programs.nixvim = {
      enable = true;

      plugins = {
        # Status Line
        lualine = {
          enable = true;
          settings.options = {
            section_separators = {
              left = "";
              right = "";
            };
            component_separators = {
              left = "";
              right = "";
            };
          };
        };

        # Pretty UI
        noice.enable = true;

        # Highlighting
        treesitter.enable = true;

        # Fuzzy Finder
        telescope.enable = true;
        web-devicons.enable = true; # Dependency for telescope

        # Rainbow Brackets
        rainbow-delimiters.enable = true;

        # Auto Comments
        comment.enable = true;

        # Nix Language Support
        nix.enable = true;
      };
    };
  };
}
