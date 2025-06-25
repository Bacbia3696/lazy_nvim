return {
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
        border = "thin",
      },
      checkbox = {
        enabled = true,
      },
      heading = {
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
    },
  },
}
