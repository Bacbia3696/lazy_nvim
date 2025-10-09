local pomodoro_25_5 = function()
  local t = require("timers.timer")
  local d = require("timers.duration")
  local u = require("timers.unit")
  local m = require("timers.manager")

  local function create_pomodoro_timer()
    local pomodoro_duration = d.from(25 * u.MINUTE)
    return t.new(pomodoro_duration, {
      title = "Pomodoro",
      message = "Pomodoro is over",
      icon = "",
      on_finish = function()
        -- Start break timer
        local break_duration = d.from(5 * u.MINUTE)
        local break_timer = t.new(break_duration, {
          title = "Break",
          message = "Break is over",
          log_level = vim.log.levels.WARN,
          icon = "⏾",
          on_finish = function()
            -- After break, start new pomodoro (infinite loop)
            m.start_timer(create_pomodoro_timer())
          end,
        })
        m.start_timer(break_timer)
        vim.system({
          "osascript",
          "-e",
          'display notification "Good job! Time for a break ☕️🍵" with title "Pomodoro"',
        })
        vim.system({ "afplay", "/System/Library/Sounds/Glass.aiff" })
      end,
      on_start = function()
        vim.system({
          "osascript",
          "-e",
          'display notification "Pomodoro started - time to focus! 🍅" with title "Pomodoro"',
        })
        vim.system({ "afplay", "/System/Library/Sounds/Glass.aiff" })
      end,
    })
  end

  m.start_timer(create_pomodoro_timer())
end

return {
  {
    "ramilito/kubectl.nvim",
    -- use a release tag to download pre-built binaries
    version = "2.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    dependencies = "saghen/blink.download",
    opts = {},
  },
  {
    "mistricky/codesnap.nvim",
    build = "make",
    opts = {
      -- bg_padding = 0,
      watermark = "Leetcode",
    },
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>-",
        "<cmd>Yazi toggle<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  {
    "ravsii/timers.nvim",
    opts = {
      persistent = false,
      default_timer = {
        icon = "󱎫",
        log_level = vim.log.levels.INFO,
        message = "Finished!",
        title = "Work time",
      },
      dashboard = {
        font = "Terrace",
      },
    },
    keys = {
      { "<leader>T", "", desc = "+timers" },
      {
        "<leader>Ta",
        function()
          require("timers.ui").active_timers()
        end,
        desc = "Active timers",
      },
      {
        "<leader>Td",
        function()
          require("timers.ui").dashboard()
        end,
        desc = "Dashboard",
      },
      {
        "<leader>Tn",
        function()
          require("timers.ui").create_timer()
        end,
        desc = "New timer",
      },
      {
        "<leader>Tc",
        function()
          require("timers.ui").cancel()
        end,
        desc = "Cancel a timer",
      },
      {
        "<leader>TC",
        function()
          require("timers.ui").cancel_all()
        end,
        desc = "Cancel all timers",
      },
      { "<leader>Tp", pomodoro_25_5, desc = "Start Pomodoro 25/5 timer" },
    },
  },
}
