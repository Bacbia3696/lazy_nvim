return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = { border = vim.g.border, width = 0.8, height = 0.8 },
      ensure_installed = {
        "bash-language-server",
        "buf",
        "graphql-language-service-cli",
        "revive",
      },
    },
  },
}
