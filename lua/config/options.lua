-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.maplocalleader = ","
vim.o.swapfile = false -- disable swap file
vim.o.linebreak = true
vim.o.wrap = true
vim.o.relativenumber = false

-- ui options
vim.o.showtabline = 0
vim.o.pumblend = 0 -- transparent cmp
-- vim.o.signcolumn = "number"
-- vim.o.listchars = [[eol:¬,tab:▸·,trail:●,nbsp:⎵]]
vim.o.listchars = [[eol:¬,tab:▸·,trail:●]]
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- turn on spell check
vim.o.spell = true
vim.o.spelllang = "en_us"

-- conceal options
-- vim.o.concealcursor = "nc"

vim.g.loaded_python3_provider = 0 -- Disable the built-in Python 3 provider
vim.g.autoformat = false
vim.opt.spelloptions:append("camel")

-- add Cfilter plugin so that we can filter in quickfix window
vim.cmd("packadd cfilter")
