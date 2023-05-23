local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function set_quit_keymap(buf)
  vim.bo[buf].buflisted = false
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true, nowait = true })
end

-- close some filetypes with <q>
autocmd("FileType", {
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

autocmd("BufEnter", {
  group = Augroup("close_with_q2"),
  desc = "Make q empty filetype window",
  pattern = "*",
  callback = function(event)
    if vim.o.filetype == "" then
      set_quit_keymap(event.buf)
    end
  end,
})

vim.cmd([[
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END
]])
