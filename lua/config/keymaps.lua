-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local map = require("custom.helpers").map

map("n", "<M-a>", "ggVG")
map({ "n", "v" }, ";", ":", { nowait = true, silent = false })
map("n", "0", "^", { nowait = true, silent = false })
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

-- path manipulation
map("n", "so", [[:execute '!open %'<CR>]])
map("n", "sp", [[:execute '!echo -n %:p:h | pbcopy'<CR>]])
map("n", "sf", [[:execute '!echo -n %:p | pbcopy'<CR>]])
map("n", "sc", [[:execute 'cd %:p:h'<CR>]])
map("n", "sd", function()
  local line = vim.fn.expand("%:p") .. ":" .. vim.fn.line(".")
  local command = "echo -n '" .. line .. "' | pbcopy"
  command = "!" .. vim.fn.escape(command, "!")
  vim.fn.execute(command)
end, { desc = "copy file and line number" })

-- git
if Util.has("gitsigns.nvim") then
  map("n", "<leader>gT", require("gitsigns").toggle_current_line_blame, { desc = "Toggle current line blame" })
  map("n", "]g", require("gitsigns").next_hunk, { desc = "Next git hunk" })
  map("n", "[g", require("gitsigns").prev_hunk, { desc = "Prev git hunk" })
end

-- Move Lines
map("n", "<M-s>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<M-w>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<M-s>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<M-w>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<M-s>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<M-w>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- this will be replace with Command-S in allacriy config
map({ "i", "v", "n", "s" }, "<M-o>", function()
  if next(vim.lsp.get_active_clients({ bufnr = 0 })) ~= nil then
    vim.lsp.buf.format({
      timeout_ms = 5000,
    })
  end
  vim.cmd("up")
  vim.cmd("stopi")
end, { desc = "Format and save" })

-- tabs
map("n", "<leader>j", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })
map("n", "<leader>k", "<cmd>tabnext<cr>", { desc = "Next Tab" })
for i = 1, 9 do
  map("n", "<leader>" .. i, "<cmd>tabn " .. i .. "<cr>", { desc = "Move to tab " .. i })
end
