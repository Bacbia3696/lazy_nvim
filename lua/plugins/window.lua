return {
  {
    "folke/zen-mode.nvim",
    events = "ZenMode",
    opts = {
      window = {
        options = {
          fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
        },
      },
      plugins = {
        tmux = { enabled = true }, -- disables the tmux statusline
      },
      on_open = function ()
        vim.cmd("hi ZenBg guibg=None")
      end
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
  },
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup({
        selection_chars = "QWEASDZXC",
        fg_color = "#FFABCB",
        include_current_win = true,
        other_win_hl_color = "#41644A",
        filter_rules = {
          bo = {
            filetype = {},
            buftype = {},
          },
        },
      })
    end,
  },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    opts = {
      autowidth = {
        enable = false,
      },
      animation = {
        enable = true,
        duration = 150,
        fps = 40,
        easing = "in_out_sine",
      },
    },
    config = function(_, opts)
      local function cmd(command)
        return table.concat({ "<Cmd>", command, "<CR>" })
      end

      vim.keymap.set("n", "<C-w>z", cmd("WindowsMaximize"))
      vim.keymap.set("n", "<C-w>_", cmd("WindowsMaximizeVertically"))
      vim.keymap.set("n", "<C-w>|", cmd("WindowsMaximizeHorizontally"))
      vim.keymap.set("n", "<C-w>=", cmd("WindowsEqualize"))

      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup(opts)
    end,
  },
}
