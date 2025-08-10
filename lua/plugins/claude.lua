return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
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
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    opts = {
      copilot_node_command = "/opt/homebrew/bin/node", -- Node.js version must be > 20
    },
  },
}
