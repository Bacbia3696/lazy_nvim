-- emacs emulator
require("config.emacs")

local Util = require("lazyvim.util")
local map = require("helpers").map

map("n", "<M-a>", "ggVG")
map({ "n", "v" }, ";", ":", { nowait = true, silent = false })
map("n", "0", "^", { nowait = true })
map("n", "<C-q>", "<Cmd>quit<cr>")
map("n", "<leader>W", "<Cmd>noa wa<cr>", { desc = "Save without format" })
map("n", "<C-g>", "2<C-g>")
map("t", "<C-q>", "<C-\\><C-n>")

-- reset key
map("v", "<", "<")
map("v", ">", ">")

-- Move Lines
map("n", "<M-Down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<M-Up>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<M-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<M-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<M-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<M-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- save file
map({ "i", "x", "n", "s" }, "<C-S-s>", "<cmd>up<cr>", { desc = "Save file" })
map({ "i", "x", "n", "s" }, "<C-s>", function()
  Util.format({ force = true })
  vim.cmd.stopi()
  vim.cmd.up()
end, { desc = "Save file and format" })

-- path manipulation
require("which-key").register({ ["<leader>y"] = { name = "clipboard " } }, {})
map("n", "<leader>yo", function()
  require("helpers").open(vim.fn.expand("%"))
end, { desc = "Open file" })
map("n", "<leader>yp", function()
  require("helpers").copy(vim.fn.expand("%:p:h"))
end, { desc = "Copy dirpath" })
map("n", "<leader>yf", function()
  require("helpers").copy(vim.fn.expand("%:p"))
end, { desc = "Copy filepath" })
map("n", "<leader>yd", function()
  require("helpers").copy(vim.fn.expand("%:p") .. ":" .. vim.fn.line("."))
end, { desc = "Copy filepath" })
map("n", "<leader>yy", "<cmd>%y<cr>", { desc = "Copy all file" })

-- git
map("n", "<leader>gb", function()
  Util.terminal(
    { "git", "blame", vim.fn.expand("%") },
    { size = { height = 0.8, width = 0.8 }, env = { LESS = "-SRX" } }
  )
end, { desc = "Git blame current file" })
map("n", "<leader>gw", function()
  Util.terminal(
    { "git", "whatchanged", "-p", vim.fn.expand("%") },
    { size = { height = 0.8, width = 0.8 }, env = { LESS = "-SRX" } }
  )
end, { desc = "Git whatchanged current file" })
map("n", "<leader>gd", function()
  Util.terminal(
    { "git", "diff", "-p", vim.fn.expand("%") },
    { size = { height = 0.8, width = 0.8 }, env = { LESS = "-SRX" } }
  )
end, { desc = "Git diff current file" })
