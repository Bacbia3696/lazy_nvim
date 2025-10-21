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

-- Disable Copilot for LeetCode files
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("disable_copilot_leetcode"),
  desc = "Disable Copilot for LeetCode files",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "copilot" then
      return
    end

    local bufnr = args.buf
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local leetcode_path = vim.fn.stdpath("data") .. "/leetcode"

    -- Detach Copilot if buffer is in leetcode directory
    if bufname:match(vim.pesc(leetcode_path)) then
      vim.schedule(function()
        vim.lsp.buf_detach_client(bufnr, client.id)
      end)
    end
  end,
})
