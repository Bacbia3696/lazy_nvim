return {
  {
    "folke/noice.nvim",
    keys = function(_, keys)
      for i, v in ipairs(keys) do
        if v[1] == "<c-f>" or v[1] == "<c-b>" then
          keys[i] = nil
        end
      end
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        colors.border = "#565f89"
      end,
      style = "moon",
      hide_inactive_statusline = true,
      dim_inactive = true,
      lualine_bold = true,
    },
  },
}
