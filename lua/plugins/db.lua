return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    opts = {
      -- lazy load the plugin or not?
      lazy = false,

      -- list of connections
      -- don't commit that, use something like nvim-projector for project specific config.
      connections = {
        {
          name = "postgres",
          type = "postgres",
          url = "postgres://postgres:password@localhost:5432/db?sslmode=disable",
        },
      },
      -- extra table helpers per connection type
      extra_helpers = {
        ["postgres"] = {
          ["List All"] = "select * from {table}",
        },
      },
    },
    config = function(_, opts)
      require("dbee").setup(opts)
    end,
  },
  {
    "dariuscorvus/surrealdb.nvim",
    config = function()
      local surrealdb = require("surrealdb-nvim")
      surrealdb.setup({})
    end,
  },
  {
    "dariuscorvus/tree-sitter-surrealdb.nvim",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("tree-sitter-surrealdb").setup()
    end,
  },
  -- {
  --   "dariuscorvus/tree-sitter-language-injection.nvim",
  --   dependencies = { "nvim-treesitter" },
  --   config = function()
  --     require("tree-sitter-language-injection").setup()
  --   end,
  -- },
}
