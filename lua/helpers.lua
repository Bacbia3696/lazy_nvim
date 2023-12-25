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
---@param text any
function M.copy(text)
  if type(text) == "string" then
    vim.fn.setreg("+", text)
    require("lazyvim.util").info(text, { title = "Copied to clipboard" })
  end
end

--- Custom on attach function when load lsp
function M.on_attach()
  local keys = require("lazyvim.plugins.lsp.keymaps").get()

  table.insert(keys, { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" })
  -- table.insert(keys, { "gL", vim.lsp.codelens.refresh, desc = "LSP CodeLens refresh" })
  -- table.insert(keys, { "gl", vim.lsp.codelens.run, desc = "LSP CodeLens run" })
  -- the default by Lazy break Zen mode
  -- table.insert(keys, { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" })
  -- table.insert(keys, { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" })
  -- table.insert(keys, { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" })

  -- if client.name == "tsserver" then
  --   client.server_capabilities.semanticTokensProvider = nil
  -- end
end

return M
