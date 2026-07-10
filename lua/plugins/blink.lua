return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      menu = {
        border = vim.g.border,
      },
      ghost_text = {
        show_with_menu = false,
      },
      documentation = {
        window = {
          border = vim.g.border,
        },
      },
    },
    keymap = {
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-b>"] = {},
      ["<C-f>"] = {},
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = {},
    },
  },
}
