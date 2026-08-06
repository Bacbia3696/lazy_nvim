return {
  {
    "gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
  -- snacks_picker defines <leader>gd/gD for git diff; Diffview owns those here
  {
    "folke/snacks.nvim",
    optional = true,
    keys = {
      { "<leader>gd", false },
      { "<leader>gD", false },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview (working tree)" },
      { "<leader>gD", "<cmd>DiffviewOpen origin/master...HEAD<cr>", desc = "Diffview (branch vs master)" },
      { "<leader>gv", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview file history (repo)" },
      { "<leader>gV", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview file history (current file)" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
      keymaps = {
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
      },
    },
  },
  {
    "ahkohd/difft.nvim",
    keys = {
      {
        "<leader>gt",
        function()
          if Difft.is_visible() then
            Difft.hide()
            return
          end
          local file = vim.fn.expand("%:p")
          if file == "" then
            vim.notify("No file in buffer to diff", vim.log.levels.WARN)
            return
          end
          -- Set config.command so "r" (refresh) stays file-scoped
          require("difft").get_config().command =
            "GIT_EXTERNAL_DIFF='difft --color=always' git diff -- " .. vim.fn.shellescape(file)
          Difft.diff()
        end,
        desc = "Toggle Difft (current file)",
      },
      {
        "<leader>gT",
        function()
          if Difft.is_visible() then
            Difft.hide()
            return
          end
          -- Reset config.command so "r" (refresh) covers all changes
          require("difft").get_config().command = "GIT_EXTERNAL_DIFF='difft --color=always' git diff"
          Difft.diff()
        end,
        desc = "Toggle Difft (all changes)",
      },
    },
    opts = {
      command = "GIT_EXTERNAL_DIFF='difft --color=always' git diff",
      layout = "float", -- Centered floating window
      keymaps = {
        next = "<C-j>", -- Next file change
        prev = "<C-k>", -- Previous file change
        close = "q", -- Close diff window (float only)
        refresh = "r", -- Refresh diff
        first = "gg", -- First file change
        last = "G", -- Last file change
      },
      diff = {
        highlights = {
          add = "DiffAdd", -- Additions (green) - ANSI codes 32, 92
          delete = "DiffDelete", -- Deletions (red) - ANSI codes 31, 91
          change = "DiffChange", -- Changes (yellow) - ANSI codes 33, 93
          info = "DiagnosticInfo", -- Info (blue/cyan) - ANSI codes 34, 94, 36, 96
          hint = "DiagnosticHint", -- Hints (magenta) - ANSI codes 35, 95
          dim = "Comment", -- Dim text (gray/white) - ANSI codes 30, 90, 37, 97
        },
      },
    },
  },
}
