-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.foldcolumn = "1" -- '0' will hide fold column
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldlevelstart = 10
vim.o.foldenable = true

vim.o.swapfile = false -- disable swap file which is annoying
vim.o.linebreak = true
vim.o.relativenumber = false
vim.o.wrap = true

-- ui options
vim.o.laststatus = 3 -- global statusline
vim.o.pumblend = 0 -- transparent cmp
vim.o.signcolumn = "yes"
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.listchars = [[eol:¬,tab:▸·,trail:●,nbsp:⎵]]
vim.o.listchars = [[eol:¬,tab:▸·,trail:●]]

-- turn on spell check
vim.o.spell = true
vim.o.spelllang = "en_us"

-- conceal options
-- vim.o.concealcursor = "nc"
vim.o.conceallevel = 2

vim.g.autoformat = false
vim.g.maplocalleader = ","

-- add Cfilter plugin so that we can filter in quickfix window
vim.cmd("packadd cfilter")
