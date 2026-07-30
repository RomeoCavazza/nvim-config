return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Flash remote",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash treesitter search",
      },
      {
        "<c-s>",
        mode = "c",
        function()
          require("flash").toggle()
        end,
        desc = "Flash toggle search",
      },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },

  {
    "nat-418/boole.nvim",
    event = "VeryLazy",
    opts = {
      mappings = {
        increment = "<leader>+",
        decrement = "<leader>-",
      },
    },
    config = function(_, opts)
      require("boole").setup(opts)
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      filetypes = {
        "css",
        "html",
        "hypr",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "nix",
        "scss",
        "typescript",
      },
      user_default_options = {
        names = false,
        mode = "background",
        tailwind = false,
      },
    },
    config = function(_, opts)
      require("colorizer").setup(opts)
    end,
  },
}
