return {
  {
    "gitsigns.nvim",
    opts = {
      current_line_blame = true,
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
          else
            Difft.diff()
          end
        end,
        desc = "Toggle Difft",
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
