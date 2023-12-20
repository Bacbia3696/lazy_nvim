local leet_arg = "leetcode.nvim"

---@param text string
local function appendText(text)
  local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
  if first_line ~= text then
    vim.api.nvim_buf_set_lines(0, 0, 1, false, { text, "", first_line })
    vim.cmd("up")
  end
end

return {
  "bacbia3696/leetcode.nvim",
  cond = leet_arg == vim.fn.argv()[1],
  lazy = false,
  keys = {
    { "<localleader>t", "<Cmd>Leet tabs<CR>" },
    { "<localleader>d", "<Cmd>Leet desc<CR>" },
    { "<localleader>D", "<Cmd>Leet daily<CR>" },
    { "<localleader>,", "<Cmd>Leet run<CR>" },
    { "<localleader>r", "<Cmd>Leet random<CR>" },
    { "<localleader>e", "<Cmd>Leet random difficulty=Easy<CR>" },
    { "<localleader>m", "<Cmd>Leet random difficulty=Medium<CR>" },
    { "<localleader>h", "<Cmd>Leet random difficulty=Hard<CR>" },
    { "<localleader><cr>", "<Cmd>Leet submit<CR>" },
    { "<localleader>i", "<Cmd>Leet info<CR>" },
    { "<localleader>c", "<Cmd>Leet console<CR>" },
    { "<localleader>p", "<Cmd>Leet list<CR>" },
    { "<localleader>l", "<Cmd>Leet lang<CR>" },
    { "<localleader><space>", "<Cmd>Leet<CR>" },
  },
  opts = {
    arg = leet_arg,
    lang = "rust",
    directory = vim.fn.stdpath("data") .. "/leetcode/",
    console = {
      result = {
        size = "62%", -- avoid space at the end
      },
    },
    description = {
      width = "50%",
    },
    hooks = {
      ---@type fun()[]
      LeetEnter = {},
      ---@type fun(question: { lang: string })[]
      LeetQuestionNew = {
        function(arg)
          -- insert package main in the in first line to make gopls happy
          if arg.lang == "golang" then
            appendText("package main")
          end
          if arg.lang == "rust" then
            appendText("struct Solution {}")
          end
          vim.cmd([[
          silent! TimerStop
          silent! TimerStart 25m Leetcode
          ]])
        end,
      },
    },
    image_support = false,
  },
}
