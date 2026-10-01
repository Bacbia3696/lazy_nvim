return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "gt", vim.lsp.buf.type_definition, desc = "Goto Type Definition" },
    },
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        gopls = {
          cmd_env = {
            GOMAXPROCS = "2",
            GOMEMLIMIT = "1536MiB",
          },
          settings = {
            gopls = {
              usePlaceholders = true,
              hints = {
                parameterNames = true,
              },
              analyses = {
                SA4023 = false,
                ST1000 = false,
                fieldalignment = false,
              },
            },
          },
        },
      },
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
          source = true,
        },
        virtual_text = {
          spacing = 4,
          source = true,
          prefix = "●",
        },
      },
      format = {
        timeout_ms = 5000,
      },
    },
  },
  {
    "folke/neoconf.nvim",
    opts = {
      plugins = {
        lua_ls = {
          enabled = true,
        },
      },
    },
  },
}
