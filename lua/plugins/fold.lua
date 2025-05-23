local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󱞡 %d.........."):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, { "Title", "Italic" } })
  return newVirtText
end

return {
  "kevinhwang91/nvim-ufo",
  enabled = false,
  event = "VeryLazy",
  dependencies = {
    { "kevinhwang91/promise-async" },
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
          relculright = true,
          segments = {
            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
            { text = { "%s" }, click = "v:lua.ScSa" },
            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          },
        })
      end,
    },
  },
  init = function()
    vim.o.foldcolumn = "1" -- '0' will hide fold column
    vim.o.foldlevelstart = 99
  end,
  keys = {
    -- stylua: ignore
    {"zK", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "UFO fold preview"},
  },
  opts = {
    fold_virt_text_handler = handler,
    preview = { -- full transparent preview window
      win_config = {
        winblend = 0,
      },
      mappings = {
        scrollU = "<C-u>",
        scrollD = "<C-d>",
      },
    },
  },
}
