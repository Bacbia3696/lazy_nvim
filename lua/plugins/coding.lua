return {
  {
    "folke/snacks.nvim",
    opts = {
      styles = {
        terminal = {
          border = vim.g.border,
        },
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    opts = {
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%[%.%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = {},
      mappings = {
        -- exclude b'', and <' for Rust
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^ac-z\\&<].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
    },
  },
}
