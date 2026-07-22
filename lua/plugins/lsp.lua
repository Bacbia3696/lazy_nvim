return {
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
}
