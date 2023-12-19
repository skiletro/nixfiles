{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      yuck-vim
      {
        plugin = catppuccin-nvim; # Mocha is default
        config = "colorscheme catppuccin";
      }
      {
        plugin = comment-nvim;
        config = "lua require('Comment').setup()";
      }
      {
        plugin = lualine-nvim;
        config = ''
          lua << EOF
          require('lualine').setup {
            icons_enabled = true,
            options = {
              section_separators = { left = '', right = '' },
              component_separators = { left = '', right = '' }
            }
          }
          EOF
        '';
      }
      {
        plugin = impatient-nvim;
        config = "lua require('impatient')";
      }
      {
        plugin = telescope-nvim;
        config = "lua require('telescope').setup()";
      }
      rainbow-delimiters-nvim
      {
        plugin = nvim-treesitter;
        config = ''
          lua << EOF
          require('nvim-treesitter.configs').setup {
            highlight = {
              enable = true,
            },
            rainbow = {
              enable = true,
              query = 'rainbow-parens',
              strategy = require('ts-rainbow').strategy.global,
            }
          }
          EOF
        '';
      }
      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
          require('lspconfig').rnix.setup{}
          require('lspconfig').lua_ls.setup{}
          require('lspconfig').bashls.setup{}
          require('lspconfig').pyright.setup{}
          require('lspconfig').emmet_language_server.setup {
            filetypes = { 'css', 'html' },
          }
          require('lspconfig').rust_analyzer.setup {
            settings = {
              ['rust-analyzer'] = {},
            },
          }
          EOF
        '';
      }
      friendly-snippets
      cmp-nvim-lsp
      {
        plugin = nvim-cmp;
        config = ''
          lua << EOF
          local cmp = require('cmp')
          cmp.setup {
            mapping = cmp.mapping.preset.insert {
              ['<C-n>'] = cmp.mapping.select_next_item(),
              ['<C-p>'] = cmp.mapping.select_prev_item(),
              ['<C-d>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete {},
              ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              },
              ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                else
                  fallback()
                end
              end, { 'i', 's' }),
              ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                else
                  fallback()
                end
              end, { 'i', 's' }),
            },
            sources = {
              { name = 'nvim_lsp' },
            },
          }
          EOF
        '';
      }
    ];

    extraLuaConfig = ''
      vim.g.mapLeader = ' '
      vim.g.mapLocalLeader = ' '

      vim.o.clipboard = 'unnamedplus'

      vim.o.number = true

      vim.o.signcolumn = 'yes'

      vim.o.tabstop = 2
      vim.o.shiftwidth = 2

      vim.o.updatetime = 300

      vim.o.termguicolors = true

      vim.o.mouse = 'a'

      if vim.g.neovide then
        vim.o.guifont = "Iosevka Comfy:h12"
        vim.g.neovide_padding_top = 10
        vim.g.neovide_padding_bottom = 5
        vim.g.neovide_padding_right = 10
        vim.g.neovide_padding_left = 10
        vim.g.neovide_refresh_rate = 144
      end
    '';

    # Langauge server stuff!
    extraPackages = with pkgs; [
      rnix-lsp
      lua-language-server
      nodePackages.bash-language-server
      nodePackages.pyright
      nur.repos.bandithedoge.nodePackages.emmet-language-server
    ];
  };

  xdg.configFile."neovide/config.toml".text = ''
    multigrid = true
  '';
}
