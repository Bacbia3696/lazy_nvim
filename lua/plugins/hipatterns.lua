return {
  "nvim-mini/mini.hipatterns",
  opts = {
    highlighters = {
      hex_color = {
        pattern = "#%x%x%x%x%x%x",
        group = function(_, match)
          return MiniHipatterns.compute_hex_color_group(match, "fg")
        end,
        extract = function(_, match)
          return match, "#%x%x%x%x%x%x" == match and match:sub(2) or nil
        end,
      },
      shorthand = {
        pattern = "#%x%x%x",
        group = function(_, match)
          return MiniHipatterns.compute_hex_color_group("#" .. match:sub(2):rep(2), "fg")
        end,
        extract = function(_, match)
          return match, "#%x%x%x" == match and match:sub(2):rep(2) or nil
        end,
      },
    },
  },
}
