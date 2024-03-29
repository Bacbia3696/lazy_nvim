return {
  {
    "kndndrj/nvim-dbee",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup({
        sources = {
          -- require("dbee.sources").MemorySource:new({
          --   {
          --     name = "avatar",
          --     type = "sqlite",
          --     url = "/Users/nguyenthanhdat/playgroud/demo-rust/db.sql",
          --   },
          -- }),
          -- require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
          -- require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
        },
      })
    end,
  },

  -- surrealdb
  {
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
