return {
  {
    "folke/neoconf.nvim",
    opts = {
      local_settings = ".neoconf.json",
      global_settings = "neoconf.json",
      import = {
        vscode = true, -- local .vscode/settings.json
        coc = true, -- global/local coc-settings.json
        nlsp = true, -- global/local nlsp-settings.nvim json settings
      },
      live_reload = true,
      filetype_jsonc = true,
      plugins = {
        lspconfig = {
          enabled = true,
        },
        jsonls = {
          enabled = true,
          configured_servers_only = false,
        },
        lua_ls = {
          enabled_for_neovim_config = true,
          enabled = true,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      require("lspconfig.ui.windows").default_options = {
        border = "rounded",
      }
      require("lazyvim.util").lsp.on_attach(require("helpers").on_attach)
    end,
    opts = {
      diagnostics = {
        float = { border = "rounded" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Error,
            [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
            [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
          },
        },
      },
      format = {
        timeout_ms = 5000,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = { border = "rounded", width = 0.8, height = 0.8 },
    },
  },
}
