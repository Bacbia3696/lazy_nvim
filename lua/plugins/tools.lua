-- Global pomodoro counter
_G.pomodoro_count = _G.pomodoro_count or 0

local pomodoro_25_5 = function()
  local t = require("timers.timer")
  local d = require("timers.duration")
  local u = require("timers.unit")
  local m = require("timers.manager")
  local config = require("timers.config")

  -- Helper to call default callbacks + custom logic
  local function with_default(default_cb, custom_fn)
    return function(timer, timer_id)
      if default_cb then
        default_cb(timer, timer_id)
      end
      if custom_fn then
        custom_fn(timer, timer_id)
      end
    end
  end

  local function create_pomodoro_timer()
    return t.new(d.from(25 * u.MINUTE), {
      title = "Pomodoro",
      message = "Pomodoro is over! Time for a break ☕️",
      -- icon = "",
      icon = "🍅",
      on_finish = with_default(config.default_timer.on_finish, function()
        -- Increment pomodoro counter when a work session completes
        _G.pomodoro_count = _G.pomodoro_count + 1
        -- Start break timer that loops back to pomodoro
        m.start_timer(t.new(d.from(5 * u.MINUTE), {
          title = "Break",
          message = "Break is over! Back to work 🍅",
          -- icon = "⏾",
          icon = "☕️",
          on_finish = with_default(config.default_timer.on_finish, function()
            m.start_timer(create_pomodoro_timer())
          end),
        }))
      end),
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
    cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapASCII" },
    opts = {
      bg_padding = 0,
      watermark = "",
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
        -- icon = "󱎫",
        icon = "🕰️",
        log_level = vim.log.levels.INFO,
        message = "Finished!",
        title = "Work time",
        on_start = function()
          vim.system({ "afplay", "/System/Library/Sounds/Tink.aiff" })
        end,
        on_finish = function()
          vim.system({ "afplay", "/System/Library/Sounds/Glass.aiff" })
        end,
      },
      dashboard = {
        font = "Terrace",
      },
    },
    keys = {
      { "<leader>T", "", desc = "+timers" },
      {
        "<leader>Tt",
        function()
          vim.ui.input({
            prompt = "Timer duration (e.g., 25m, 1h30m): ",
          }, function(input)
            if input and input ~= "" then
              vim.cmd("TimersStart " .. input)
            end
          end)
        end,
        desc = "Start timers",
      },
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
      {
        "<leader>Tr",
        function()
          _G.pomodoro_count = 0
          vim.notify("Pomodoro counter reset to 0", vim.log.levels.INFO)
        end,
        desc = "Reset Pomodoro counter",
      },
    },
  },
}
