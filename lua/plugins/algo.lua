local leet_arg = "leetcode.nvim"

return {
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    opts = {},
  },
  {
    "kawre/leetcode.nvim",
    cond = vim.fn.argv()[1] == leet_arg,
    lazy = false,
    keys = {
      { "<localleader>t", "<Cmd>Leet tabs<CR>" },
      { "<localleader>d", "<Cmd>Leet desc<CR>" },
      { "<localleader>D", "<Cmd>Leet daily<CR>" },
      { "<localleader><localleader>", "<Cmd>Leet run<CR>" },
      { "<localleader>r", "<Cmd>Leet random<CR>" },
      { "<localleader>e", "<Cmd>Leet random difficulty=Easy<CR>" },
      { "<localleader>m", "<Cmd>Leet random difficulty=Medium<CR>" },
      { "<localleader>h", "<Cmd>Leet random difficulty=Hard<CR>" },
      { "<localleader>R", "<Cmd>Leet random status=todo<CR>" },
      { "<localleader>E", "<Cmd>Leet random difficulty=Easy status=todo<CR>" },
      { "<localleader>M", "<Cmd>Leet random difficulty=Medium status=todo<CR>" },
      { "<localleader>H", "<Cmd>Leet random difficulty=Hard status=todo<CR>" },
      { "<localleader><cr>", "<Cmd>Leet submit<CR>" },
      { "<localleader>i", "<Cmd>Leet info<CR>" },
      { "<localleader>c", "<Cmd>Leet console<CR>" },
      { "<localleader>p", "<Cmd>Leet list<CR>" },
      { "<localleader>l", "<Cmd>Leet lang<CR>" },
      { "<localleader><space>", "<Cmd>Leet<CR>" },
    },
    opts = {
      arg = leet_arg,
      lang = "golang",
      storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
        cache = vim.fn.stdpath("cache") .. "/leetcode",
      },
      console = {
        result = {
          size = "62%", -- avoid space at the end
        },
      },
      description = {
        width = "50%",
      },
      injector = {
        ["rust"] = {
          before = { "struct Solution {}" },
        },
        ["golang"] = {
          before = { "package main" },
        },
        ["cpp"] = {
          before = { "#include <bits/stdc++.h>", "using namespace std;" },
          after = "int main() {}",
        },
        ["java"] = {
          before = "import java.util.*;",
        },
      },
      image_support = false,
    },
  },
}
