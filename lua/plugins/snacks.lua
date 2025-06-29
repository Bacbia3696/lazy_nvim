return {
  "folke/snacks.nvim",
  opts = {
    zen = {
      toggles = {
        dim = false,
      },
    },
    image = {
      enabled = true,
    },
    picker = {
      ui_select = { enabled = true },
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          follow = true,
        },
      },
      -- formatters = {
      --   file = {
      --     filename_first = true,
      --   },
      -- },
    },
  },
}
