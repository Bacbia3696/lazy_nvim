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

autocmd("FileType", {
  group = Augroup("http"),
  pattern = "http",
  callback = function()
    vim.keymap.set("n", "r", require("rest-nvim").run, { buffer = true, desc = "Rest run current" })
    vim.keymap.set("n", "<c-r>", require("rest-nvim").last, { buffer = true, desc = "Rest run all" })
    vim.keymap.set("n", "K", "<Plug>RestNvimPreview", { buffer = true, desc = "Rest preview curl" })
  end,
})

autocmd("FileType", {
  group = Augroup("go"),
  pattern = "go",
  callback = function()
    vim.o.expandtab = false
  end,
})

-- Persistent Folds
-- local save_fold = augroup("Persistent Folds", { clear = true })
-- autocmd("BufWinLeave", {
--   pattern = "*.*",
--   callback = function()
--     vim.cmd.mkview()
--   end,
--   group = save_fold,
-- })
-- autocmd("BufWinEnter", {
--   pattern = "*.*",
--   callback = function()
--     vim.cmd.loadview({ mods = { emsg_silent = true } })
--     vim.cmd("stopinsert")
--   end,
--   group = save_fold,
-- })

-- Cursor Line on each window
-- autocmd({ "InsertLeave", "WinEnter" }, {
--   callback = function()
--     local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
--     if ok and cl then
--       vim.wo.cursorline = true
--       vim.api.nvim_win_del_var(0, "auto-cursorline")
--     end
--   end,
-- })
-- autocmd({ "InsertEnter", "WinLeave" }, {
--   callback = function()
--     local cl = vim.wo.cursorline
--     if cl then
--       vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
--       vim.wo.cursorline = false
--     end
--   end,
-- })
