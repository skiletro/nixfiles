local plugins = {

  -- edit lsp config
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "html",
        "cssls",
        "nixd",
        "emmet_language_server",
        "jsonls"
      },
    },
  },
  
  -- language highlighting
  { "elkowar/yuck.vim", lazy = false},

  -- rainbow delimiters
  { "HiPhish/rainbow-delimiters.nvim" },

  -- ui changes
  { "stevearc/dressing.nvim", lazy = true },

  { 
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },

}

return plugins
