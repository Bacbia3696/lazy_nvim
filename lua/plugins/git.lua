return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>ght", require("gitsigns").toggle_current_line_blame, { desc = "Toggle git current line blame" } },
      { "<leader>ghT", require("gitsigns").toggle_deleted, { desc = "Toggle git deleted lines" } },
      { "]g", require("gitsigns").next_hunk, { desc = "Next git hunk" } },
      { "[g", require("gitsigns").prev_hunk, { desc = "Prev git hunk" } },
    },
    opts = function(_, opts)
      opts.current_line_blame = true
    end,
  },
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
  },
}
