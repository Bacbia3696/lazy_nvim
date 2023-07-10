-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldlevelstart = 10
vim.o.foldenable = true
vim.o.swapfile = false
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.listchars = [[eol:¬,tab:▸·,trail:●,nbsp:⎵]]
vim.o.listchars = [[eol:¬,tab:▸·,trail:●]]
vim.o.linebreak = true
vim.o.relativenumber = false
vim.o.laststatus = 3
vim.o.pumblend = 0 -- transparent cmp
vim.o.signcolumn = "yes"
vim.o.conceallevel = 2
vim.o.wrap = true
vim.o.concealcursor = "nc"

vim.g.python3_host_prog = "~/.pyenv/versions/nvim/bin/python"

-- add Cfilter plugin
vim.cmd("packadd cfilter")
