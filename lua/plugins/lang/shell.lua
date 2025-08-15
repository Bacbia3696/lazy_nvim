return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "bash-language-server" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "bash", "sh", "zsh" },
        },
      },
    },
  },
}
