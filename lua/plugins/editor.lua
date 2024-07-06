return {
  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        HACK = { icon = " ", color = "warning", alt = { "SAFETY", "Safety" } },
      },
    },
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "folke/which-key.nvim",
    opts = {
      win = {
        border = "rounded", -- none, single, double, shadow
      },
    },
  },
  {
    "johmsalas/text-case.nvim",
    opts = true,
    lazy = false,
  },
  {
    "stevearc/aerial.nvim",
    opts = function()
      return {
        backends = { "treesitter", "lsp", "markdown", "man" },
        layout = {
          max_width = { 45, 0.2 },
          width = nil,
          min_width = 25,
        },
      }
    end,
  },
}
