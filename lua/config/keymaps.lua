-- emacs emulator
require("config.emacs")

local map = require("helpers").map

map("n", "<M-a>", "<cmd>%y<cr>", { desc = "yank all" })
map({ "n", "v" }, ";", ":", { nowait = true, silent = false })
map("n", "0", "^", { nowait = true })
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
require("which-key").add({ { "<leader>y", group = "clipboard", icon = "" } })

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

map("n", "<leader>uV", "<cmd>DapVirtualTextToggle<cr>", { desc = "Toggle Dap virtual text" })
map("n", "<C-`>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "right" } })
end, { desc = "Terminal (Root Dir)" })
map("t", "<C-`>", "<cmd>close<cr>", { desc = "Hide Terminal" })
