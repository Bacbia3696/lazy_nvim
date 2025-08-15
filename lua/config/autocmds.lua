local function set_quit_keymap(buf)
  vim.bo[buf].buflisted = false
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true, nowait = true })
end

local bind_key = function()
  vim.keymap.set("n", "<leader><leader>", function()
    vim.api.nvim_feedkeys("v", "n", false)
    vim.api.nvim_feedkeys("im", "v", false)
    vim.schedule(function()
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
        vim.fn.chansend(job_id, visual.text .. "\n")
        vim.fn.chansend(job_id, "\x1b[201~\n") -- End paste mode

        terminal:show()
        -- Scroll to bottom
        vim.api.nvim_buf_call(terminal.buf, function()
          vim.cmd("normal! G")
        end)
      else
        vim.notify("Terminal job not found", vim.log.levels.ERROR)
      end
    end)
  end, {
    desc = "Send code block to terminal",
    buffer = true,
  })
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = augroup("keymap_markdown"),
  callback = bind_key,
})

-- Also run for already open markdown buffers
vim.schedule(function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "markdown" then
      bind_key()
    end
  end
end)
