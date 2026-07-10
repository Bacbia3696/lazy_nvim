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
        "<leader>ao",
        function()
          require("sidekick.cli").toggle({ name = "opencode", focus = true })
        end,
        desc = "Sidekick OpenCode Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>am",
        function()
          require("sidekick.cli").toggle({ name = "omp", focus = true })
        end,
        desc = "Sidekick Omp Toggle",
        mode = { "n", "v" },
      },
    },
    opts = {
      -- Work with AI cli tools directly from within Neovim
      cli = {
        tools = {
          omp = {
            cmd = { "omp" },
            is_proc = "\\<omp\\>",
            resume = { "--resume" },
            continue = { "--continue" },
            native_scroll = false,
          },
        },
        win = {
          layout = "right",
          keys = {
            prompt = { "<a-p>", "prompt", mode = "t", desc = "insert prompt or context" },
          },
        },
      },
    },
  },
}
