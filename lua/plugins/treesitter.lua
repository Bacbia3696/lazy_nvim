return {
  {
    "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<cr>", desc = "Increment selection" },
      { "<s-cr>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    dependencies = {
      { "HiPhish/nvim-ts-rainbow2" },
      { "windwp/nvim-ts-autotag" },
      { "nvim-treesitter/playground" },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          scope_incremental = "<s-cr>",
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },

      -- extension config
      rainbow = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
      playground = {
        enable = true,
      },
    },
  },
}
