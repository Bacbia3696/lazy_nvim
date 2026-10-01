local function set_quit_keymap(buf)
  vim.bo[buf].buflisted = false
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true, nowait = true })
end

local augroup = require("helpers").augroup

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = augroup("close_with_q2"),
  desc = "Close special buffers (terminal, scratch) with q",
  callback = function(event)
    -- buftype ~= "" excludes normal buffers, e.g. a fresh :enew buffer
    if vim.bo[event.buf].filetype == "" and vim.bo[event.buf].buftype ~= "" then
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
        local c = vim.lsp.get_client_by_id(args.data.client_id)
        if c then
          vim.lsp.buf_detach_client(bufnr, c.id)
        end
      end)
    end
  end,
})

-- Contextual cursorline: show only in active window
local cursorline_group = augroup("cursorline_active")
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = cursorline_group,
  desc = "Cursorline only in active window",
  callback = function()
    vim.wo.cursorline = true
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline_group,
  desc = "Disable cursorline in inactive windows",
  callback = function()
    vim.wo.cursorline = false
  end,
})

-- Statuscolumn: calls helpers.statuscolumn() (hidden on special buffers)
vim.opt.statuscolumn = "%{%v:lua.require('helpers').statuscolumn()%}"

-- Disable number and signcolumn for special buffers
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("clean_special_buffers"),
  desc = "No line numbers on dashboard and special buffers",
  pattern = { "snacks_dashboard", "alpha", "dashboard", "lazy", "mason", "help", "aerial", "grug-far" },
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = "no"
  end,
})

-- Detach LSP clients from non-file buffers (diffview:// git-object buffers, fugitive://, etc.).
-- gopls and other servers reject any DocumentURI whose scheme isn't "file", spamming
-- "-32700: JSON RPC parse error: DocumentURI scheme is not 'file'".
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("no_lsp_on_virtual_buffers"),
  desc = "Detach LSP from diffview/fugitive virtual buffers",
  callback = function(args)
    local scheme = vim.uri_from_bufnr(args.buf):match("^(%a[%w+.-]*)://")
    if scheme and scheme ~= "file" then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(args.buf) then
          local c = vim.lsp.get_client_by_id(args.data.client_id)
          if c then
            vim.lsp.buf_detach_client(args.buf, c.id)
          end
        end
      end)
    end
  end,
})
