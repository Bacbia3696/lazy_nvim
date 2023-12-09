return {
  {
    "folke/persistence.nvim",
    -- add folds options when persist session
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" } },
  },
  {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat" },
    dependencies = {
      "rcarriga/nvim-notify",
    },
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
  -- open file with format filename:linenumber
  { "lewis6991/fileline.nvim" },
}
