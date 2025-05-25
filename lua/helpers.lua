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
    LazyVim.info(text, { title = "Copied to clipboard" })
  end
end

return M
