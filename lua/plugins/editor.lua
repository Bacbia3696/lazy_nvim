return {
  {
    "stevearc/aerial.nvim",
    opts = function()
      return {
        layout = {
          max_width = { 40, 0.2 },
          width = nil,
          min_width = 20,
        },
      }
    end,
  },
  {
    "folke/flash.nvim",
    keys = function()
      return {}
    end,
    opts = {
      modes = { search = { enabled = false } },
    },
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        HACK = { icon = " ", color = "warning", alt = { "SAFETY", "Safety" } },
      },
    },
  },
  {
    "johmsalas/text-case.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      require("textcase").setup(opts)
      require("telescope").load_extension("textcase")
      vim.api.nvim_set_keymap("", "<leader>ga", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Change text case" })
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {
      highlight = {
        ui = "@keyword",
        search = "NeogitDiffDeleteHighlight",
        replace = "NeogitDiffAddHighlight",
      },
    },
  },
  {
    "rest-nvim/rest.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("rest-nvim").setup({
        --- Get the same options from Packer setup
      })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        zindex = 1000, -- positive value to position WhichKey above other floating windows.
      },
    },
  },
}
