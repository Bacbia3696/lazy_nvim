-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

Map("n", "<M-a>", "ggVG")
Map({ "n", "v" }, ";", ":", { nowait = true, silent = false })
Map("n", "0", "^", { nowait = true, silent = false })
Map("n", "<C-q>", "<Cmd>quit<cr>")
Map("n", "<leader>W", "<Cmd>noa wa<cr>", { desc = "Save without format all buffers" })
Map("n", "<C-g>", "2<C-g>")
Map("t", "<C-q>", "<C-\\><C-n>")

-- reset key
Map("v", "<", "<")
Map("v", ">", ">")

-- emacs like in insert and command mode
Map("!", "<C-a>", "<Home>", { desc = "move begin line", silent = false })
Map("!", "<C-e>", "<End>", { desc = "move eol", silent = false })
Map("!", "<C-p>", "<Up>", { desc = "move up", silent = false })
Map("!", "<C-n>", "<Down>", { desc = "move down", silent = false })
Map("!", "<C-b>", "<Left>", { desc = "move left", silent = false })
Map("!", "<C-f>", "<Right>", { desc = "move right", silent = false })
Map("!", "<M-b>", "<S-Left>", { desc = "move 1 word", silent = false })
Map("!", "<M-f>", "<S-Right>", { desc = "move back 1 word", silent = false })

-- path manipulation
Map("n", "so", [[:execute '!open %'<CR>]])
Map("n", "sp", [[:execute '!echo -n %:p:h | pbcopy'<CR>]])
Map("n", "sf", [[:execute '!echo -n %:p | pbcopy'<CR>]])
Map("n", "sc", [[:execute 'cd %:p:h'<CR>]])
Map("n", "sd", function()
  local line = vim.fn.expand("%:p") .. ":" .. vim.fn.line(".")
  local command = "echo -n '" .. line .. "' | pbcopy"
  command = "!" .. vim.fn.escape(command, "!")
  vim.fn.execute(command)
end, { desc = "copy file and line number" })

-- git
if Util.has("gitsigns.nvim") then
  Map("n", "<leader>gT", require("gitsigns").toggle_current_line_blame, { desc = "Toggle current line blame" })
  Map("n", "]g", require("gitsigns").next_hunk, { desc = "Next git hunk" })
  Map("n", "[g", require("gitsigns").prev_hunk, { desc = "Prev git hunk" })
end

-- Move Lines
Map("n", "<M-s>", "<cmd>m .+1<cr>==", { desc = "Move down" })
Map("n", "<M-w>", "<cmd>m .-2<cr>==", { desc = "Move up" })
Map("i", "<M-s>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
Map("i", "<M-w>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
Map("v", "<M-s>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
Map("v", "<M-w>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- this will be replace with Command-S in allacriy config
Map({ "i", "v", "n", "s" }, "<M-o>", function()
  if next(vim.lsp.get_active_clients({ bufnr = 0 })) ~= nil then
    vim.lsp.buf.format({
      timeout_ms = 5000,
    })
  end
  vim.cmd("up")
  vim.cmd("stopi")
end, { desc = "Format and save" })

-- tabs
Map("n", "<leader>j", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })
Map("n", "<leader>k", "<cmd>tabnext<cr>", { desc = "Next Tab" })
for i = 1, 9 do
  Map("n", "<leader>" .. i, "<cmd>tabn " .. i .. "<cr>", { desc = "Move to tab " .. i })
end
