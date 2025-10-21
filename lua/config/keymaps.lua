-- emacs emulator
require("config.emacs")

local map = require("helpers").map

-- Select all without animation
vim.keymap.set("n", "<M-a>", function()
  local prev = vim.b.snacks_animate
  vim.b.snacks_animate = false
  vim.cmd("normal! ggVG")
  vim.b.snacks_animate = prev
end, { desc = "Select all (no animation)" })
map({ "n", "v" }, ";", ":", { nowait = true, silent = false })
map("n", "0", "^", { nowait = true })

-- Quit window
map("n", "<C-q>", "<Cmd>quit<cr>")
map("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" })
map("n", "<leader>W", "<Cmd>noa wa<cr>", { desc = "Save without format" })

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
  LazyVim.format({ force = true })
  vim.cmd.stopi()
  vim.cmd.up()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end, { desc = "Save file and format" })

-- path manipulation
pcall(function()
  require("which-key").add({ { "<leader>y", group = "clipboard", icon = "" } })
end)
map("n", "<leader>yo", function()
  vim.ui.open(vim.fn.expand("%"))
end, { desc = "Open file" })
map("n", "<leader>yp", function()
  require("helpers").copy(vim.fn.expand("%:p:h"))
end, { desc = "Copy dirpath" })
map("n", "<leader>yf", function()
  require("helpers").copy(vim.fn.expand("%:p"))
end, { desc = "Copy filepath" })
map("n", "<leader>yd", function()
  require("helpers").copy(vim.fn.expand("%:p") .. ":" .. vim.fn.line("."))
end, { desc = "Copy filepath with linenumber" })
map("n", "<leader>yy", function()
  require("helpers").copy(vim.fn.expand("%:t"))
end, { desc = "Copy filename" })
map("n", "<leader>ya", "<cmd>%y<cr>", { desc = "Copy all file" })

-- toggle
Snacks.toggle
  .new({
    name = "diagnostics virtual text",
    get = function()
      return vim.diagnostic.config().virtual_text ~= false
    end,
    set = function(state)
      vim.diagnostic.config({
        virtual_text = state and {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        } or false,
      })
    end,
  })
  :map("<leader>uv")

-- dap
map("n", "<leader>uV", "<cmd>DapVirtualTextToggle<cr>", { desc = "Toggle Dap virtual text" })

-- hotkey open float terminal
map("n", "<C-`>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "right" } })
end, { desc = "Terminal (Root Dir)" })
map("t", "<C-`>", "<cmd>close<cr>", { desc = "Hide Terminal" })
