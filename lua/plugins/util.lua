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
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
    },
    opts = {
      -- See below for full list of options 👇
    },
  },
}
