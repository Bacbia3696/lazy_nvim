local M = {}

function M.contain(table, val)
  for _, value in ipairs(table) do
    if value == val then
      return true
    end
  end
  return false
end

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
