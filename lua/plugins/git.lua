return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>ghtb", require("gitsigns").toggle_current_line_blame, desc = "Toggle git current line blame" },
      { "<leader>ghtd", require("gitsigns").toggle_deleted, desc = "Toggle git deleted lines" },
      { "<leader>ghth", require("gitsigns").toggle_linehl, desc = "Toggle git line highlight" },
    },
    opts = function(_, opts)
      opts.current_line_blame = true
    end,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "", desc = "+diffview" },
      { "<leader>gdo", "<Cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
      { "<leader>gdc", "<Cmd>DiffviewClose<CR>", desc = "Close Diffview" },
      { "<leader>gdh", "<Cmd>DiffviewFileHistory %<CR>", desc = "Diffview current file history" },
    },
    lazy = false,
  },
}
