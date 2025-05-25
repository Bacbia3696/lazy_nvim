return {
  -- { "kevinhwang91/nvim-bqf", ft = "qf", opts = { preview = { winblend = 0 } } },
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
    },
  },
}
