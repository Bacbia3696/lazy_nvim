return {
  {
    "folke/persistence.nvim",
    -- add folds options when persist session
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" } },
  },
}
