-- emacs emulator
require("config.emacs")

local map = require("helpers").map

map("n", "<M-a>", "ggVG")
map({ "n", "v" }, ";", ":", { nowait = true, silent = false })
map("n", "0", "^", { nowait = true })
map("n", "<C-q>", "<Cmd>quit<cr>")
map("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" })
map("n", "<leader>W", "<Cmd>noa wa<cr>", { desc = "Save without format" })
map("n", "<C-g>", "2<C-g>")

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

-- git
map("n", "<leader>gw", function()
  Snacks.terminal(
    { "git", "whatchanged", "-p", vim.fn.expand("%") },
    { size = { height = 0.8, width = 0.8 }, env = { LESS = "-SRX" } }
  )
end, { desc = "Git whatchanged current file" })
map("n", "<leader>gD", function()
  Snacks.terminal(
    { "git", "diff", "-p", vim.fn.expand("%") },
    { size = { height = 0.8, width = 0.8 }, env = { LESS = "-SRX" } }
  )
end, { desc = "Git diff current file" })

Snacks.toggle
  .new({
    name = "diagnostics virtual text",
    get = function()
      return vim.b.virtual_text == nil and true or vim.b.virtual_text
    end,
    set = function(state)
      vim.diagnostic.config({ virtual_text = state })
      vim.b.virtual_text = state
    end,
  })
  :map("<leader>uv")

map("n", "<leader>uV", "<cmd>DapVirtualTextToggle<cr>", { desc = "Toggle Dap virtual text" })

-- send selection text to terminal
vim.keymap.set("v", "<leader><leader>", function()
  local visual = require("snacks.picker.util").visual()
  if not visual or not visual.text then
    vim.notify("No visual selection found", vim.log.levels.WARN)
    return
  end

  local terminals = require("snacks").terminal.list()
  if #terminals == 0 then
    vim.notify("No terminals found", vim.log.levels.WARN)
    return
  end

  local terminal = terminals[#terminals]
  local job_id = vim.b[terminal.buf].terminal_job_id

  if job_id then
    -- Use paste mode to prevent shell interpretation
    vim.fn.chansend(job_id, "\x1b[200~") -- Start paste mode
    vim.fn.chansend(job_id, visual.text)
    vim.fn.chansend(job_id, "\x1b[201~") -- End paste mode

    terminal:show()

    vim.fn.chansend(job_id, "\n")

    -- Scroll to bottom
    vim.api.nvim_buf_call(terminal.buf, function()
      vim.cmd("normal! G")
    end)
  else
    vim.notify("Terminal job not found", vim.log.levels.ERROR)
  end
end, {
  desc = "Send visual selection to terminal",
})
