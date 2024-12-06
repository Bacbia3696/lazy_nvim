return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    keys = {
      { "<localleader>d", "<Cmd>ObsidianDailies<CR>", ft = "markdown" },
      { "<localleader>t", "<Cmd>ObsidianToggleCheckbox<CR>", ft = "markdown" },
    },
    opts = {
      ui = {
        enable = false,
      },
      workspaces = {
        {
          name = "personal",
          path = "~/obsidian/personal",
        },
        {
          name = "work",
          path = "~/obsidian/work",
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      preset = "lazy",
      code = {
        sign = true,
      },
      heading = {
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      render_modes = true,
    },
  },
}
