local function set_quit_keymap(buf)
  vim.bo[buf].buflisted = false
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true, nowait = true })
end

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = require("helpers").augroup("close_with_q"),
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
  pattern = "*",
  group = require("helpers").augroup("close_with_q2"),
  desc = "Make q empty filetype window",
  callback = function(event)
    if vim.o.filetype == "" then
      set_quit_keymap(event.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  group = require("helpers").augroup("disable_auto_comment"),
  desc = "Disable auto comment next line",
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "norg" },
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})

-- Disable diagnostics for markdown and environment files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "sh" },
  group = require("helpers").augroup("disable_diagnostics"),
  desc = "Disable diagnostics for markdown files",
  callback = function(event)
    vim.diagnostic.enable(false, { bufnr = event.buf })
    vim.opt_local.spell = false
  end,
})
