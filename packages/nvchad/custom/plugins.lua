local plugins = {
  
  -- direnv, kinda its own thing?
  { "direnv/direnv.vim", lazy = false },

  -- language highlighting
  { "elkowar/yuck.vim", lazy = false},

  -- ui changes
  { "rcarriga/nvim-notify" },
  
  { "stevearc/dressing.nvim", lazy = true },

  { 
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
  },

  { "MunifTanjim/nui.nvim", lazy = true }

}

return plugins
