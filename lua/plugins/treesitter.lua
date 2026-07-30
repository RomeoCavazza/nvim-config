return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      vim.filetype.add({
        pattern = {
          [".*/hypr/.*%.conf"] = "hypr",
          [".*/hyprland%.conf"] = "hypr",
        },
      })

      if vim.treesitter.language and vim.treesitter.language.register then
        vim.treesitter.language.register("hyprlang", "hypr")
      end

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "css",
          "html",
          "hyprlang",
          "javascript",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "markdown_inline",
          "nix",
          "regex",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        sync_install = false,
        auto_install = true,

        highlight = { enable = true },
        indent = { enable = false },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          include_surrounding_whitespace = true,
        },
        move = {
          set_jumps = true,
        },
      })

      local select = function(query)
        return function()
          require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
        end
      end

      local move = function(method, query)
        return function()
          require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
        end
      end

      vim.keymap.set({ "x", "o" }, "af", select("@function.outer"), { desc = "Select function outer" })
      vim.keymap.set({ "x", "o" }, "if", select("@function.inner"), { desc = "Select function inner" })
      vim.keymap.set({ "x", "o" }, "ac", select("@class.outer"), { desc = "Select class outer" })
      vim.keymap.set({ "x", "o" }, "ic", select("@class.inner"), { desc = "Select class inner" })
      vim.keymap.set({ "x", "o" }, "aa", select("@parameter.outer"), { desc = "Select parameter outer" })
      vim.keymap.set({ "x", "o" }, "ia", select("@parameter.inner"), { desc = "Select parameter inner" })

      vim.keymap.set({ "n", "x", "o" }, "]f", move("goto_next_start", "@function.outer"), { desc = "Next function" })
      vim.keymap.set({ "n", "x", "o" }, "]c", move("goto_next_start", "@class.outer"), { desc = "Next class" })
      vim.keymap.set({ "n", "x", "o" }, "]a", move("goto_next_start", "@parameter.inner"), { desc = "Next parameter" })
      vim.keymap.set(
        { "n", "x", "o" },
        "[f",
        move("goto_previous_start", "@function.outer"),
        { desc = "Previous function" }
      )
      vim.keymap.set({ "n", "x", "o" }, "[c", move("goto_previous_start", "@class.outer"), { desc = "Previous class" })
      vim.keymap.set(
        { "n", "x", "o" },
        "[a",
        move("goto_previous_start", "@parameter.inner"),
        { desc = "Previous parameter" }
      )
    end,
  },

  {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textsubjects").configure({
        prev_selection = ",",
        keymaps = {
          ["."] = "textsubjects-smart",
          [";"] = "textsubjects-container-outer",
          ["i;"] = "textsubjects-container-inner",
        },
      })
    end,
  },
}
