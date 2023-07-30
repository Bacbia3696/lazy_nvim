return {
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- optional
    },
    version = "1.x.x", -- recommended
  },
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
    opts = function(_, opts)
      require("lspconfig.ui.windows").default_options = {
        border = "rounded",
      }
      require("lazyvim.util").lsp.on_attach(require("custom.lsp").on_attach)

      -- opts.diagnostics.virtual_text = { spacing = 4, prefix = "●", source = true }
      opts.diagnostics.float = { border = "rounded" }
      opts.format = {
        formatting_options = nil,
        timeout_ms = 5000,
      }
      opts.inlay_hints = {
        enabled = true,
      }
    end,
  },
  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "nvimtools/none-ls.nvim",
  --   },
  --   opts = {
  --     ensure_installed = {},
  --     automatic_installation = false,
  --     handlers = {},
  --   },
  -- },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = { border = "rounded", width = 0.8, height = 0.8 },
    },
  },
}
