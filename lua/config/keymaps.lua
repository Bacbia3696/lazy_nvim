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
map("n", ";", ":", { nowait = true, silent = false })
map("n", "<C-q>", "<Cmd>quit<cr>")
map("t", "<C-q>", "<C-\\><C-n>")

-- emacs like in insert and command mode
map("!", "<C-a>", "<Home>", { desc = "move begin line", silent = false })
map("!", "<C-e>", "<End>", { desc = "move eol", silent = false })
map("!", "<C-p>", "<Up>", { desc = "move up", silent = false })
map("!", "<C-n>", "<Down>", { desc = "move down", silent = false })
map("!", "<C-b>", "<Left>", { desc = "move left", silent = false })
map("!", "<C-f>", "<Right>", { desc = "move right", silent = false })
map("!", "<M-b>", "<S-Left>", { desc = "move 1 word", silent = false })
map("!", "<M-f>", "<S-Right>", { desc = "move back 1 word", silent = false })

-- togle term
if Util.has("toggleterm.nvim") then
  map({ "n", "t" }, "<C-\\>", "<Cmd>ToggleTerm<cr>")
end

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

if Util.has("nvim-dap") then
  local dap = require("dap")
  -- modified function keys found with `showkey -a` in the terminal to get key code
  -- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
  map("n", "<F5>", dap.continue, { desc = "Debugger: Start" })
  map("n", "<F17>", dap.terminate, { desc = "Debugger: Stop" }) -- Shift + F5
  map("n", "<F29>", dap.restart_frame, { desc = "Debugger: Restart" }) -- Control + F5
  map("n", "<F6>", dap.pause, { desc = "Debugger: Pause" })
  map("n", "<F9>", dap.toggle_breakpoint, { desc = "Debugger: Toggle Breakpoint" })
  map("n", "<F21>", function()
    dap.set_breakpoint(vim.fn.input("Set condition:"))
  end, { desc = "Debugger: Set condition breakpoint" })
  map("n", "<F33>", dap.clear_breakpoints, { desc = "Debugger: Clear all breakpoints" })
  map("n", "<F10>", dap.step_over, { desc = "Debugger: Step Over" })
  map("n", "<F11>", dap.step_into, { desc = "Debugger: Step Into" })
  map("n", "<F23>", dap.step_out, { desc = "Debugger: Step Out" }) -- Shift + F11
  map("n", "<leader>dq", dap.close, { desc = "Debugger: Close session" })
  map("n", "<leader>dR", dap.repl.toggle, { desc = "Toggle REPL" })
  if Util.has("nvim-dap-ui") then
    map("n", "<leader>du", require("dapui").toggle, { desc = "Toggle Debugger UI" })
    map("n", "<leader>dh", require("dap.ui.widgets").hover, { desc = "Debugger Hover" })
  end
end

if Util.has("aerial.nvim") then
  map("n", "<leader>cs", "<cmd>AerialToggle<cr>", { desc = "Toggle LSP Symbol" })
end

if Util.has("nvim-window-picker") then
  local picker = require("window-picker")
  map("n", "-", function()
    local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
  end, { desc = "Pick a window" })
end

if Util.has("smart-splits.nvim") then
  map("n", "<leader>w ", require("smart-splits").start_resize_mode, { desc = "Start resize mode" })
end
