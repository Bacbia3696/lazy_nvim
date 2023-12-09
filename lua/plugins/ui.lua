return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    enabled = false,
    config = function()
      local rainbow = require("rainbow-delimiters")
      require("rainbow-delimiters.setup")({
        strategy = {
          [""] = rainbow.strategy["global"],
          commonlisp = rainbow.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          latex = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        blacklist = { "c", "cpp" },
      })
    end,
  },
  {
    "folke/noice.nvim",
    keys = function(_, keys)
      -- use <C-d>, <C-u> instead of <C-f>, <C-b>
      keys[6] = {
        "<c-d>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-d>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      }
      keys[7] = {
        "<c-u>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-u>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      }
    end,
    opts = {
      lsp = {
        progress = { enabled = false },
        hover = {
          silent = true,
        },
        documentation = {
          view = "hover",
          ---@type NoiceViewOptions
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            size = {
              width = "auto",
              height = "auto",
              max_height = 20,
              max_width = 80,
            },
            win_options = { concealcursor = "n", conceallevel = 0 },
          },
        },
      },
      messages = {
        view_error = "mini", -- view for errors
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      ---@type NoiceConfigViews
      views = {
        mini = { win_options = { winblend = 0 } },
        hover = { border = { padding = { 0, 0 } } },
      }, ---@see section on views
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      top_down = false,
      background_colour = "#000000",
      fps = 60,
      level = 2,
      minimum_width = 50,
      render = "default",
    },
    config = function(_, opts)
      for _, level in ipairs({ "ERROR", "WARN", "INFO", "DEBUG", "TRACE" }) do
        vim.cmd("hi Notify" .. level .. "Body guibg=none")
        vim.cmd("hi Notify" .. level .. "Title guibg=none")
        vim.cmd("hi Notify" .. level .. "Border guibg=none")
      end
      require("notify").setup(opts)
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      on_colors = function(colors)
        -- colors.git.change = colors.cyan
        colors.gitSigns.change = colors.blue2
      end,
      on_highlights = function(hl, colors)
        hl.FoldColumn = { bg = colors.none, fg = colors.comment }
        hl.SignColumn = { bg = colors.none }
        hl.WinSeparator = { link = "FloatBorder" }
        hl.DiagnosticUnnecessary = { link = "NonText" }
        hl.LineNr = { fg = colors.dark3 }
        hl.CursorLineNr = { fg = colors.blue }
        hl.Folded = { bg = colors.none }
        hl.LspInlayHint = { fg = "#0db9d7", bg = "#203346", italic = true }
        hl.CmpGhostText = { fg = "#567189", italic = true }
        hl.Todo = { fg = "#0db9d7" }
        -- fix bg of DiagnosticFloating (default is black)
        hl.DiagnosticFloatingError = hl.DiagnosticError
        hl.DiagnosticFloatingWarn = hl.DiagnosticWarn
        hl.DiagnosticFloatingInfo = hl.DiagnosticInfo
        hl.DiagnosticFloatingHint = hl.DiagnosticHint
        hl.DiagnosticFloatingOk = hl.DiagnosticOk
      end,
      hide_inactive_statusline = true,
      dim_inactive = true,
      lualine_bold = true,
      translarent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "linrongbin16/lsp-progress.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "linrongbin16/lsp-progress.nvim",
    },
    opts = function(_, opts)
      local Util = require("lazyvim.util")
      local icons = require("lazyvim.config").icons

      local auto_theme_custom = require("lualine.themes.auto")
      auto_theme_custom.normal.c.bg = "none"
      opts.options = {
        section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },

        theme = auto_theme_custom,
      }
      -- show lsp client instead of key
      opts.sections.lualine_b = {
        Util.lualine.root_dir(),
        { Util.lualine.pretty_path() },
        { "filetype", icon_only = true, separator = "" },
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
      }
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      }
      opts.sections.lualine_c = {
        {
          function()
            return require("nvim-navic").get_location()
          end,
          cond = function()
            return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          end,
        },
      }
      opts.sections.lualine_x[1] = {
        -- Setup lsp-progress component
        function()
          return require("lsp-progress").progress({
            max_size = 80,
            format = function(messages)
              local active_clients = vim.lsp.get_clients()
              if #messages > 0 then
                return table.concat(messages, " ")
              end
              local client_names = {}
              for _, client in ipairs(active_clients) do
                if client and client.name ~= "" then
                  table.insert(client_names, 1, client.name)
                end
              end
              return table.concat(client_names, "  ")
            end,
          })
        end,
        icon = { "", align = "right" },
      }
      opts.sections.lualine_y = { "branch" }
      opts.sections.lualine_z = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      }
      -- table.remove(opts.sections.lualine_x, 1)
    end,
  },
  {
    "SmiteshP/nvim-navic",
    opts = function(_, opts)
      opts.highlight = false
    end,
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal", winblend = 0 },
      },
      select = {
        backend = { "telescope", "builtin" },
        telescope = require("telescope.themes").get_cursor({
          layout_config = {
            width = 50,
            height = 9,
          },
        }),
        -- builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
      },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      default = true,
      override = {
        astro = { icon = "󰘯", name = "Astro", color = "#FF6969" },
        deb = { icon = "", name = "Deb" },
        http = { icon = "", name = "FireFox", color = "#98D8AA" },
        tsx = { icon = "", color = "#00A9FF", cterm_color = "26", name = "Tsx" },
        ["robots.txt"] = { icon = "󰚩", name = "Robots" },
        xz = { icon = "", name = "Xz" },
        zip = { icon = "", name = "Zip" },
      },
    },
  },
  {
    "xiyaowong/transparent.nvim",
    opts = {},
  },
}
