return {
  {
    "mrcjkb/rustaceanvim",
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = {
            replace_builtin_hover = false,
          },
          -- float_win_config = {
          --   border = "rounded",
          -- },
        },
      }
    end,
  },
  {
    "Saecki/crates.nvim",
    opts = {
      popup = {
        autofocus = true,
        border = vim.g.border,
      },
    },
  },
}
