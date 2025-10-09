local function set_quit_keymap(buf)
  vim.bo[buf].buflisted = false
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true, nowait = true })
end

local augroup = require("helpers").augroup

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = augroup("close_with_q2"),
  desc = "Make q empty filetype window",
  callback = function(event)
    if vim.o.filetype == "" then
      set_quit_keymap(event.buf)
    end
  end,
})
