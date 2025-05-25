return {
  {
    "epwalsh/obsidian.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
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
    "OXY2DEV/markview.nvim",
    enabled = false,
    lazy = false,
    opts = {
      preview = {
        icon_provider = "mini",
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      render_modes = true,
      preset = "lazy",
      code = {
        sign = true,
      },
      heading = {
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
    },
  },
}
