return {
  {
    "folke/sidekick.nvim",
    keys = {
      {
        "<leader>aA",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Sidekick Claude Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "cursor", focus = true })
        end,
        desc = "Sidekick Cursor Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>aC",
        function()
          require("sidekick.cli").toggle({ name = "copilot", focus = true })
        end,
        desc = "Sidekick Copilot Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>ag",
        function()
          require("sidekick.cli").toggle({ name = "gemini", focus = true })
        end,
        desc = "Sidekick Gemini Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          require("sidekick.cli").toggle({ name = "qwen", focus = true })
        end,
        desc = "Sidekick Qwen Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        function()
          require("sidekick.cli").toggle({ name = "opencode", focus = true })
        end,
        desc = "Sidekick OpenCode Toggle",
        mode = { "n", "v" },
      },
    },
    opts = {
      -- Work with AI cli tools directly from within Neovim
      cli = {
        win = {
          keys = {
            prompt = { "<a-p>", "prompt", mode = "t", desc = "insert prompt or context" },
          },
        },
      },
    },
  },
}
