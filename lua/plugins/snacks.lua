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
      previewers = {
        git = {
          builtin = false, -- use Neovim for previewing git output (true) or use git (false)
          args = {}, -- additional arguments passed to the git command. Useful to set pager options usin `-c ...`
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
