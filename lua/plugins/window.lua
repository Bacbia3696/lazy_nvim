return {
  {
    "folke/zen-mode.nvim",
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" } },
    opts = {
      plugins = {
        options = {
          laststatus = 0,
        },
        tmux = { enabled = true },
      },
      window = {
        height = 0.8,
        width = 100,
        options = {
          signcolumn = "number",
          foldcolumn = "0",
        },
      },
    },
  },
  {
    "aserowy/tmux.nvim",
    keys = { "<M-h>", "<M-j>", "<M-k>", "<M-l>", "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
    opts = {
      copy_sync = {
        sync_registers = false, -- avoid lagging when sync register
      },
    },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf", opts = { preview = { winblend = 0 } } },
  {
    "s1n7ax/nvim-window-picker",
    event = "VeryLazy",
    keys = {
      {
        "-",
        function()
          local window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(window_id)
        end,
      },
    },
    opts = {
      hint = "floating-big-letter",
      selection_chars = "QWEASDZXC",
      show_prompt = false,
      filter_rules = {
        include_current_win = true,
        bo = {
          filetype = {},
          buftype = {},
          -- exclude window create by treesitter-context
          bufhidden = { "wipe" },
        },
        -- filter using window options
        wo = {},
      },
    },
  },
}
