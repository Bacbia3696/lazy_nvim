-- https://github.com/j/blob/main/plugin/nvimacs.lua
local map = require("helpers").map
--- Navigation

-- backward-char
map("!", "<C-b>", "<Left>", { silent = false })

-- forward-char
map("!", "<C-f>", "<Right>", { silent = false })

-- previous-line
map("!", "<C-p>", "<Up>", { silent = false })

-- next-line
map("!", "<C-n>", "<Down>", { silent = false })

-- move-beginning-of-line
map("!", "<C-a>", "<Home>", { silent = false })

-- move-end-of-line
map("!", "<C-e>", "<End>", { silent = false })

-- backward-sentence
map("i", "<M-a>", "<C-o>(", { silent = true })

-- forward-sentence
map("i", "<M-e>", "<C-o>)", { silent = true })

-- backward-word
map("i", "<M-b>", "<C-Left>", { silent = true })
map("c", "<M-b>", "<S-Left>", { silent = false })

-- forward-word
map("i", "<M-f>", "<C-o>e<Right>", { silent = true })
map("c", "<M-f>", "<S-Right>", { silent = false })

-- scroll-down-command
-- map("i", "<M-v>", "<PageUp>", { silent = true })

-- scroll-up-command
-- map("i", "<C-v>", "<PageDown>", { silent = true })

--
--- Copy & Paste

-- delete-char
-- map("!", "<C-d>", "<Del>", { silent = false })

--
--- Editing

-- kill-region
map("!", "<M-BS>", "<C-w>", { silent = false })
map("i", "<C-BS>", "<C-w>", { silent = true })

-- kill-line
-- map("i", "<C-k>", function()
--   local col = vim.api.nvim_win_get_cursor(0)[2]
--   local line = vim.api.nvim_get_current_line()
--
--   if #line <= col then
--     return "<Del><C-o>dw"
--   end
--
--   return "<C-o>dw"
-- end, { silent = true, expr = true })
-- map("c", "<C-k>", "<C-f>d$<C-c><End>", { silent = false })

-- kill-word
map("i", "<M-d>", function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()

  if #line <= col then
    return "<Del>"
  end

  return "<C-o>d$"
end, { silent = true, expr = true })

-- kill-sentence
map("i", "<M-k>", "<C-o>d)", { silent = true })
