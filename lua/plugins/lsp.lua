return {
  {
    "folke/neoconf.nvim",
    opts = {
      local_settings = ".neoconf.json",
      global_settings = "neoconf.json",
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
    keys = {
      { "gt", vim.lsp.buf.type_definition, desc = "Goto Type Definition" },
    },
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        severity_sort = true,
        underline = false,
        update_in_insert = false,
        float = {
          border = vim.g.border,
          max_width = 80,
          header = false,
          prefix = function(diag)
            local icons = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = " ",
              [vim.diagnostic.severity.HINT] = " ",
            }
            return icons[diag.severity] or ""
          end,
          source = "if_many",
        },
        virtual_text = true,
      },
      format = {
        timeout_ms = 5000,
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = { border = vim.g.border, width = 0.8, height = 0.8 },
    },
  },
}
