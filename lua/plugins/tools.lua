return {
  {
    "ramilito/kubectl.nvim",
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
    "epwalsh/pomo.nvim",
    event = "VeryLazy",
    cmd = { "TimerStart", "TimerRepeat" },
    opts = {
      notifiers = {
        {
          name = "Default",
          opts = {
            sticky = false,
            -- title_icon = "󱎫",
            -- text_icon = "󰄉",
            title_icon = "⏳",
            text_icon = "⏱️",
          },
        },
        { name = "System" },
      },
      sessions = {
        pomodoro = {
          { name = "Work", duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work", duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work", duration = "25m" },
          { name = "Long Break", duration = "15m" },
        },
      },
    },
  },
}
