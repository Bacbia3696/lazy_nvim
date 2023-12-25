return {
  {
    "mikesmithgh/kitty-scrollback.nvim",
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    opts = {},
  },
  {
    "rolv-apneseth/tfm.nvim",
    event = "VeryLazy",
    config = function()
      -- Set keymap so you can open the default terminal file manager (yazi)
      vim.api.nvim_set_keymap("n", "<leader>~", "", {
        noremap = true,
        callback = require("tfm").open,
      })
    end,
  },
  {
    "folke/persistence.nvim",
    -- add folds options when persist session
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" } },
  },
  {
    "epwalsh/pomo.nvim",
    event = "VeryLazy",
    cmd = { "TimerStart", "TimerRepeat" },
    opts = {
      update_interval = 1000,
      notifiers = {
        {
          name = "Default",
          opts = {
            sticky = true,
            title_icon = "⏳",
            text_icon = "⏱️",
          },
        },
      },
    },
  },
  -- color picker
  {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
    opts = {
      highlighter = {
        auto_enable = false,
        lsp = false,
      },
    },
  },
  -- open file with format filename:linenumber
  { "lewis6991/fileline.nvim" },
}
