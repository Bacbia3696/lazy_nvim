-- define global utils function
function Augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
