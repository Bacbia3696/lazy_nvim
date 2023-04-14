-- define global utils function
function Augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

function Map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
