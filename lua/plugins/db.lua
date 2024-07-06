return {
  {
    -- surrealdb
    "dariuscorvus/surrealdb.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "dariuscorvus/tree-sitter-surrealdb.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter" },
    opts = {},
  },
}
