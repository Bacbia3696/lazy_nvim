-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<M-a>", "ggVG")
map("n", ";", ":", { nowait = true, noremap = true, silent = true })

-- emacs like in insert and command mode
map("!", "<C-a>", "<Home>")
map("!", "<C-e>", "<End>")
map("!", "<C-p>", "<Up>")
map("!", "<C-n>", "<Down>")
map("!", "<C-b>", "<Left>", { desc = "c-b" })
map("!", "<C-f>", "<Right>")
map("!", "<M-b>", "<S-Left>")
map("!", "<M-f>", "<S-Right>")

-- path manipulation
map("n", "so", [[:execute '!open %'<CR>]])
map("n", "sp", [[:execute '!echo -n %:p:h | pbcopy'<CR>]])
map("n", "sf", [[:execute '!echo -n %:p | pbcopy'<CR>]])
map("n", "sc", [[:execute 'cd %:p:h'<CR>]])
map("n", "sd", function()
  local line = vim.fn.expand("%:p") .. ":" .. vim.fn.line(".")
  local command = "echo -n '" .. line .. "' | pbcopy"
  command = "!" .. vim.fn.escape(command, "!")
  print(command)
  vim.fn.execute(command)
end, { desc = "copy file and line number" })

-- git
if Util.has("gitsigns.nvim") then
  local gs = require("gitsigns")
  map("n", "<leader>gT", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
  map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset current hunk" })
  map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset current buffer" })
end

-- neotest
if Util.has("neotest") then
  local nt = require("neotest")
  map("n", "<leader>tr", nt.run.run, { desc = "Run unit test" })
  map("n", "<leader>ts", nt.summary.toggle, { desc = "Toggle neotest summary" })
  map("n", "<leader>tR", function()
    require("neotest").run.run(vim.fn.expand("%"))
  end, { desc = "Run all unit test in file" })
  map("n", "<leader>to", nt.output.open, { desc = "Open unit test output" })
  map("n", "<leader>t]", nt.jump.next, { desc = "Jump to next test" })
  map("n", "<leader>t[", nt.jump.next, { desc = "Jump to prev test" })
  map("n", "<leader>th", "<cmd>Coverage<cr>", { desc = "Toggle show converage" })
end
