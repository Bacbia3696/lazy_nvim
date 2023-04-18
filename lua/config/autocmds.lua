-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function set_quit_keymap(buf)
  vim.bo[buf].buflisted = false
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true, nowait = true })
end

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = Augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "dap-float",
    "fugitiveblame",
    "neotest-summary",
    "neotest-output",
    "httpResult",
  },
  callback = function(event)
    set_quit_keymap(event.buf)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = Augroup("close_with_q2"),
  desc = "Make q empty filetype window",
  pattern = "*",
  callback = function(event)
    if vim.o.filetype == "" then
      set_quit_keymap(event.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = Augroup("http"),
  pattern = "http",
  callback = function()
    vim.keymap.set("n", "r", require("rest-nvim").run, { buffer = true, desc = "Rest run current" })
    vim.keymap.set("n", "<c-r>", require("rest-nvim").last, { buffer = true, desc = "Rest run all" })
    vim.keymap.set("n", "K", "<Plug>RestNvimPreview", { buffer = true, desc = "Rest preview curl" })
  end,
})
