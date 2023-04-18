-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

Map("n", "<M-a>", "ggVG")
Map("n", ";", ":", { nowait = true, silent = false })
Map("n", "<C-q>", "<Cmd>quit<cr>")
Map("n", "<leader>W", "<Cmd>noa w<cr>", { desc = "Save without format" })
Map("t", "<C-q>", "<C-\\><C-n>")

-- emacs like in insert and command mode
Map("!", "<C-a>", "<Home>", { desc = "move begin line", silent = false })
Map("!", "<C-e>", "<End>", { desc = "move eol", silent = false })
-- Map("!", "<C-p>", "<Up>", { desc = "move up", silent = false })
-- Map("!", "<C-n>", "<Down>", { desc = "move down", silent = false })
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

if Util.has("nvim-dap") then
  local dap = require("dap")
  -- modified function keys found with `showkey -a` in the terminal to get key code
  -- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
  Map("n", "<F5>", dap.continue, { desc = "Debugger: Start" })
  Map("n", "<F17>", dap.terminate, { desc = "Debugger: Stop" }) -- Shift + F5
  Map("n", "<F29>", dap.restart_frame, { desc = "Debugger: Restart" }) -- Control + F5
  Map("n", "<F6>", dap.pause, { desc = "Debugger: Pause" })
  Map("n", "<F9>", dap.toggle_breakpoint, { desc = "Debugger: Toggle Breakpoint" })
  Map("n", "<F21>", function()
    dap.set_breakpoint(vim.fn.input("Set condition:"))
  end, { desc = "Debugger: Set condition breakpoint" })
  Map("n", "<F33>", dap.clear_breakpoints, { desc = "Debugger: Clear all breakpoints" })
  Map("n", "<F10>", dap.step_over, { desc = "Debugger: Step Over" })
  Map("n", "<F11>", dap.step_into, { desc = "Debugger: Step Into" })
  Map("n", "<F23>", dap.step_out, { desc = "Debugger: Step Out" }) -- Shift + F11
  Map("n", "<leader>dq", dap.close, { desc = "Debugger: Close session" })
  Map("n", "<leader>dR", dap.repl.toggle, { desc = "Toggle REPL" })
  Map("n", "<leader>dh", require("dap.ui.widgets").hover, { desc = "Debugger Hover" })
  if Util.has("nvim-dap-ui") then
    local dapui = require("dapui")
    Map("n", "<leader>du", dapui.toggle, { desc = "Toggle Debugger UI" })
    Map("n", "<leader>df", function()
      vim.ui.select({ "scopes", "stacks", "watches", "breakpoints", "repl", "console" }, {
        prompt = "DAP UI Element",
        format_item = function(item)
          return "Show: " .. item
        end,
      }, function(elem)
        dapui.float_element(elem)
      end)
    end, { desc = "DapUI: open float" })
  end
end

if Util.has("aerial.nvim") then
  Map("n", "<leader>cs", "<cmd>AerialToggle<cr>", { desc = "Toggle LSP Symbol" })
end

if Util.has("nvim-window-picker") then
  local picker = require("window-picker")
  Map("n", "1", function()
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
