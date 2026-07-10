-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- global variable to set border in neovim
vim.g.border = "rounded" -- double,none,rounded,shadow,single
vim.g.snacks_animate = true
vim.g.autoformat = false
vim.g.maplocalleader = ","
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.root_spec = { "cwd" }

-- disable animation
-- vim.g.snacks_animate = false

vim.o.swapfile = false -- disable swap file
vim.o.linebreak = true
vim.o.wrap = true
vim.o.relativenumber = false
-- vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- ui options
vim.o.showtabline = 0
vim.o.listchars = [[eol:¬,tab:▸·,trail:●]]
vim.o.signcolumn = "yes:1"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,vert:▏]]
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.splitkeep = "screen"

-- smooth scrolling
vim.o.smoothscroll = true
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8

-- spell check
vim.o.spell = false
vim.o.spelllang = "en_us"
vim.opt.spelloptions:append("camel")

-- add Cfilter plugin so that we can filter in quickfix window
vim.cmd("packadd cfilter")
