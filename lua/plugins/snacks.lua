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
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          follow = true,
          -- your explorer picker configuration comes here
          -- or leave it empty to use the default settings
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
