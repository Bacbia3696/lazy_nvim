local M = {}

--- Util to create mapping
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table|nil
function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

--- Util to create augroup
---@param name string:
function M.augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

--- Copy `text` to system clipboard
---@param text string
function M.copy(text)
  vim.fn.setreg("*", text)
  require("lazyvim.util").info(text, { title = "Copied to clipboard" })
end

--- Custom on attach function when load lsp
function M.on_attach(client, buffer)
  local keys = require("lazyvim.plugins.lsp.keymaps").get()

  table.insert(keys, { "<leader>cS", "<cmd>LspStop<cr>", desc = "Lsp Stop" })
  table.insert(keys, { "<leader>cR", "<cmd>LspRestart<cr>", desc = "Lsp Stop" })
  table.insert(keys, { "go", vim.diagnostic.open_float, desc = "Open diagnostics on float window" })
  table.insert(keys, { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" })
  table.insert(keys, { "gL", vim.lsp.codelens.refresh, desc = "LSP CodeLens refresh" })
  table.insert(keys, { "gl", vim.lsp.codelens.run, desc = "LSP CodeLens run" })
  table.insert(keys, { "ga", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })

  -- stylua: ignore
  table.insert(keys, { "[D", function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, desc = "diagnostic goto prev ERROR",
  })
  -- stylua: ignore
  table.insert(keys, { "]D", function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, desc = "diagnostic goto next ERROR",
  })

  -- set inlay hints
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(buffer, vim.g.inlay_hints_enabled)
  end

  -- add codelens for on_attach function
  local capabilities = client.server_capabilities
  if capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter" }, {
      group = M.augroup("lsp_codelens_refresh"),
      callback = vim.lsp.codelens.refresh,
      buffer = 0,
    })
  end
end

return M
