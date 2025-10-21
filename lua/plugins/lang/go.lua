return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "revive" } },
      },
    },
    opts = {
      linters_by_ft = {
        go = { "revive" },
      },
    },
  },
}
