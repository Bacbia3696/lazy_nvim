-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

Map("n", "<M-a>", "ggVG")
Map("n", ";", ":", { nowait = true, silent = false })
Map("n", "0", "^", { nowait = true, silent = false })
Map("n", "<C-q>", "<Cmd>quit<cr>")
Map("n", "<leader>W", "<Cmd>noa wa<cr>", { desc = "Save without format all buffers" })
Map("n", "<C-g>", "2<C-g>")
Map("n", "<A-q>", "<Cmd>tabp<cr>")
Map("n", "<A-e>", "<Cmd>tabn<cr>")
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

-- togle term
-- if Util.has("toggleterm.nvim") then
--   Map({ "n", "t" }, "<C-\\>", "<Cmd>ToggleTerm<cr>")
-- end

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

-- neotest
if Util.has("neotest") then
  local nt = require("neotest")
  Map("n", "<leader>tr", nt.run.run, { desc = "Run unit test" })
  Map("n", "<leader>ts", nt.summary.toggle, { desc = "Toggle neotest summary" })
  Map("n", "<leader>tR", function()
    require("neotest").run.run(vim.fn.expand("%"))
  end, { desc = "Run all unit test in file" })
  Map("n", "<leader>to", nt.output.open, { desc = "Open unit test output" })
  Map("n", "<leader>t]", nt.jump.next, { desc = "Jump to next test" })
  Map("n", "<leader>t[", nt.jump.next, { desc = "Jump to prev test" })
  Map("n", "<leader>th", "<cmd>Coverage<cr>", { desc = "Toggle show converage" })
end

if Util.has("aerial.nvim") then
  Map("n", "<leader>cs", "<cmd>AerialToggle<cr>", { desc = "Toggle LSP Symbol" })
end

if Util.has("nvim-window-picker") then
  local picker = require("window-picker")
  Map("n", "-", function()
    local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
  end, { desc = "Pick a window" })
end

if Util.has("smart-splits.nvim") then
  Map("n", "<leader>w ", require("smart-splits").start_resize_mode, { desc = "Start resize mode" })
end

-- Move Lines
Map("n", "<A-s>", "<cmd>m .+1<cr>==", { desc = "Move down" })
Map("n", "<A-w>", "<cmd>m .-2<cr>==", { desc = "Move up" })
Map("i", "<A-s>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
Map("i", "<A-w>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
Map("v", "<A-s>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
Map("v", "<A-w>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
