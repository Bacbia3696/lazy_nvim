return {
  -- { "kevinhwang91/nvim-bqf", ft = "qf", opts = { preview = { winblend = 0 } } },
  {
    "s1n7ax/nvim-window-picker",
    event = "VeryLazy",
    keys = {
      {
        "-",
        function()
          local last_press = vim.g.dash_last_press or 0
          local current_time = vim.uv.hrtime() / 1000000
          local delay_time = 200
          if current_time - last_press < delay_time then
            -- Double-press: switch to previous window
            vim.cmd("wincmd p")
            vim.g.dash_last_press = 0
          else
            -- Single press: show window picker after delay
            vim.g.dash_last_press = current_time
            vim.defer_fn(function()
              if vim.g.dash_last_press == current_time then
                local window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
                vim.api.nvim_set_current_win(window_id)
              end
            end, delay_time)
          end
        end,
      },
    },
    opts = {
      hint = "floating-big-letter",
      selection_chars = "QWEASDZXC",
      show_prompt = false,
      include_current_win = true,
    },
  },
}
