return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      menu = {
        border = vim.g.border,
      },
      documentation = {
        window = {
          border = vim.g.border,
        },
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
    keymap = {
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-b>"] = {},
      ["<C-f>"] = {},
      ["<C-e>"] = {},
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
  },
}
