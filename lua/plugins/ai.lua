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
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    enabled = false,
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", mode = { "v", "n" }, desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    },
    opts = {
      port_range = { min = 10000, max = 65535 },
      auto_start = true,
      terminal_cmd = "~/.claude/local/claude", -- Point to local installation
      -- Selection Tracking
      track_selection = true,
      visual_demotion_delay_ms = 50,

      terminal = {
        split_side = "right", -- "left" or "right"
        split_width_percentage = 0.30,
        provider = "auto", -- "auto", "snacks", "native", "external", or custom provider table
        auto_close = true,
        snacks_win_opts = {}, -- Opts to pass to `Snacks.terminal.open()` - see Floating Window section below
        -- Provider-specific options
        provider_opts = {
          external_terminal_cmd = nil, -- Command template for external terminal provider (e.g., "alacritty -e %s")
        },
      },

      -- Diff Integration
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = false,
        open_in_current_tab = false,
        keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
      },
    },
  },
}
