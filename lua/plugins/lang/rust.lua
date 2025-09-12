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
    opts = {
      server = { status_notify_level = false },
    },
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
