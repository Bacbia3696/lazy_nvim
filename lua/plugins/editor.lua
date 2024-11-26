return {
  {
    "echasnovski/mini.files",
    opts = {
      mappings = {
        go_in_plus = "L",
        go_out_plus = "H",
        mark_goto = "'",
        mark_set = "m",
        reset = "<BS>",
        reveal_cwd = "gg",
        show_help = "g?",
        synchronize = "s",
        trim_left = "<",
        trim_right = ">",
      },
      windows = {
        width_preview = 60,
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        HACK = { icon = " ", color = "warning", alt = { "SAFETY", "Safety" } },
      },
    },
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "folke/which-key.nvim",
    opts = {
      win = {
        border = "rounded", -- none, single, double, shadow
      },
    },
  },
  {
    "johmsalas/text-case.nvim",
    opts = true,
    lazy = false,
  },
  {
    "stevearc/aerial.nvim",
    opts = function()
      return {
        post_parse_symbol = function(_, item, _)
          -- Check if the item is a method and contains a struct name
          local pattern = "%(([^%*]+%*[^%)]+)%)%s+([^%s]+)"
          local struct, method = item.name:match(pattern)
          if struct and method then
            -- Shorten the struct name
            local shortened_struct = "*" .. struct:match("%*([^%)]+)"):sub(1, 5) .. "..."
            -- Update the item name with the shortened struct and method
            item.name = "(" .. shortened_struct .. ") " .. method
          end
          return true
        end,
        backends = { "treesitter", "lsp", "markdown", "man" },
        layout = {
          max_width = { 50, 0.2 },
          width = nil,
          min_width = 25,
        },
      }
    end,
  },
}
