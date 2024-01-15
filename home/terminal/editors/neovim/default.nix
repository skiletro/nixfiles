{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      showBufferEnd = true;
    };
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      updatetime = 300;
      termguicolors = true;
      mouse = "a";
      clipboard = "unnamedplus";
      signcolumn = "yes";
      expandtab = true;
    };
    globals = {
      mapLeader = " ";
      mapLocalLeader = " ";
    };
    plugins = {
      # bottom bar
      lualine = {
        enable = true;
        iconsEnabled = true;
        sectionSeparators = {
          left = "";
          right = "";
        };
        componentSeparators = {
          left = "";
          right = "";
        };
      };

      # popup after pressing leader key
      which-key.enable = true;

      # pretty ui
      noice.enable = true;

      # highlighting
      treesitter.enable = true;

      dashboard.enable = true;

      # language servers for code checking, etc
      lsp = {
        enable = true;
        servers = {
          nixd = {
            #nix
            enable = true;
            installLanguageServer = true;
            settings.formatting.command = "alejandra";
          };
          lua-ls = {
            #lua
            enable = true;
            installLanguageServer = true;
          };
          bashls = {
            #bash
            enable = true;
            installLanguageServer = true;
          };
          pyright = {
            #python
            enable = true;
            installLanguageServer = true;
          };
          html = {
            #html
            enable = true;
            installLanguageServer = true;
          };
          cssls = {
            #css
            enable = true;
            installLanguageServer = true;
          };
          rust-analyzer = {
            #rust
            enable = true;
            installLanguageServer = true;
          };
          emmet_ls = {
            #html shorthand
            enable = true;
            installLanguageServer = true;
          };
          hls = {
            #haskell
            enable = true;
            installLanguageServer = true;
          };
          gopls = {
            #go
            enable = true;
            installLanguageServer = true;
          };
        };
      };

      # completions
      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];

        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          # TODO: fix tab stuff
        };
      };

      # fuzzy finder
      telescope.enable = true;

      # rainbow brackets
      rainbow-delimiters.enable = true;

      # auto comments
      comment-nvim.enable = true;
    };
  };

  programs.fish.shellAbbrs = {
    vi = "nvim";
    vim = "nvim";
  };
}
