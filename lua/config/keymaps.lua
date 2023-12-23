-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local map = require("helpers").map

map("n", "<M-a>", "ggVG")
map({ "n", "v" }, ";", ":", { nowait = true, silent = false })
map("n", "0", "^", { nowait = true })
map("n", "<C-q>", "<Cmd>quit<cr>")
map("n", "<leader>W", "<Cmd>noa wa<cr>", { desc = "Save without format all buffers" })
map("n", "<C-g>", "2<C-g>")
map("t", "<C-q>", "<C-\\><C-n>")

-- reset key
map("v", "<", "<")
map("v", ">", ">")

-- emacs like in insert and command mode
map("!", "<C-a>", "<Home>", { desc = "move begin line", silent = false })
map("!", "<C-e>", "<End>", { desc = "move eol", silent = false })
map("!", "<C-p>", "<Up>", { desc = "move up", silent = false })
map("!", "<C-n>", "<Down>", { desc = "move down", silent = false })
map("!", "<C-b>", "<Left>", { desc = "move left", silent = false })
map("!", "<C-f>", "<Right>", { desc = "move right", silent = false })
map("!", "<M-b>", "<S-Left>", { desc = "move 1 word", silent = false })
map("!", "<M-f>", "<S-Right>", { desc = "move back 1 word", silent = false })

-- Move Lines
map("n", "<M-S-J>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<M-S-K>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<M-S-J>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<M-S-K>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<M-S-J>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<M-S-K>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- tabs
map("n", "<leader>j", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })
map("n", "<leader>k", "<cmd>tabnext<cr>", { desc = "Next Tab" })
for i = 1, 9 do
  map("n", "<leader>" .. i, "<cmd>tabn " .. i .. "<cr>", { desc = "Move to tab " .. i })
end
map("n", "<leader><tab>o", "<cmd>tabo<cr>", { desc = "Close other tabs" })

map({ "i", "v", "n", "s" }, "<M-s>", function()
  require("lazyvim.util").format({ force = true })
  vim.cmd.up()
  vim.cmd.stopi()
  -- vim.api.nvim_feedkeys("zz", "n", true) -- center screen
end, { desc = "Format and save" })

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
if Util.has("gitsigns.nvim") then
  local gitsigns = require("gitsigns")
  map("n", "<leader>ght", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
  map("n", "<leader>ghT", gitsigns.toggle_deleted, { desc = "Toggle deleted lines" })
  map("n", "]g", gitsigns.next_hunk, { desc = "Next git hunk" })
  map("n", "[g", gitsigns.prev_hunk, { desc = "Prev git hunk" })
end
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

map("n", "<leader>uH", function()
  vim.g.inlay_hints_enabled = not vim.g.inlay_hints_enabled
  vim.lsp.inlay_hint.enable(0, vim.g.inlay_hints_enabled)
  Util.info(vim.g.inlay_hints_enabled and "Enable" or "Disable", { title = "Toggle auto inlay hints" })
end, { desc = "Toggle auto inlay hints" })
