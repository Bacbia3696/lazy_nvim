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
  vim.fn.setreg("+", text)
  LazyVim.info(text, { title = "Copied to clipboard" })
end

--- Setup Ghostty terminal title
function M.setup_ghostty()
  if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
    if vim.fn.expand("%:t"):find("kubectl-edit", 1, true) then
      return
    end
    vim.opt.title = true
    vim.opt.titlestring = "%{&buftype=='terminal'?'  ':' '} %{fnamemodify(getcwd(), ':t')}"
  end
end

return M
