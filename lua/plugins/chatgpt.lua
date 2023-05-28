return {
  {
    "jackMort/ChatGPT.nvim",
    keys = {
      { "<leader>cc", "<cmd>ChatGPT<cr>", desc = "Toggle ChatGPT" },
    },
    opts = {
      api_key_cmd = "gpg --decrypt ~/.config/nvim/chatgpt.gpg 2>/dev/null",
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "dpayne/CodeGPT.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("codegpt.config")
    end,
  },
  {
    "mthbernardes/codeexplain.nvim",
    lazy = true,
    cmd = "CodeExplain",
    build = function()
      vim.cmd([[silent UpdateRemotePlugins]])
    end,
  },
}
