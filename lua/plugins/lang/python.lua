return {
  {
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    enabled = true,
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    ft = "python",
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "basic",
              },
            },
          },
        },
      },
    },
  },
  {
    "goerz/jupytext.nvim",
    -- lazy.nvim re-triggers BufReadCmd after loading, so the plugin's read handler runs
    event = "BufReadCmd *.ipynb",
    opts = {}, -- see Options
  },
  -- nvim-dap-python is provided by the LazyVim lang.python extra
}
