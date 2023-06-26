return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        height = 0.8,
        width = 100,
        options = {
          fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
          signcolumn = "number",
        },
      },
      on_open = function()
        vim.cmd("hi ZenBg guibg=None")
        -- vim.o.signcolumn = "number"
      end,
    },
  },
  {
    "aserowy/tmux.nvim",
    lazy = true,
    keys = {
      "<M-h>",
      "<M-j>",
      "<M-k>",
      "<M-l>",
      "<C-h>",
      "<C-j>",
      "<C-k>",
      "<C-l>",
    },
    opts = {},
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    opts = {
      hint = "floating-big-letter",
      selection_chars = "QWEASDZXC",
      show_prompt = false,
      filter_rules = {
        include_current_win = true,
        bo = {
          filetype = {},
          buftype = {},
        },
      },
    },
    keys = {
      {
        "-",
        function()
          local tp = vim.o.wrap
          vim.o.wrap = false
          local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.o.wrap = tp
          vim.api.nvim_set_current_win(picked_window_id)
        end,
      },
    },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf", opts = { preview = { winblend = 0 } } },
}
