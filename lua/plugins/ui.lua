return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow.strategy["global"],
          vim = rainbow.strategy["local"],
          commonlisp = rainbow.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          -- lua = "rainbow-blocks",
          latex = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
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
        blacklist = {"go"}
      }
    end,
  },
  {
    "folke/noice.nvim",
    keys = function(_, keys)
      -- use <C-d>, <C-u> instead of <C-f>, <C-b>
      for _, value in ipairs(keys) do
        if value[1] == "<c-f>" then
          value[1] = "<c-d>"
        end
        if value[1] == "<c-b>" then
          value[1] = "<c-u>"
        end
      end
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
            win_options = { concealcursor = "n", conceallevel = 2 },
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
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        -- colors.git.change = colors.cyan
        colors.gitSigns.change = colors.blue2
      end,
      on_highlights = function(hl, colors)
        hl.FoldColumn = { bg = colors.none, fg = colors.comment }
        hl.SignColumn = { bg = colors.none }

        hl.LineNr = { fg = colors.dark3 }
        hl.CursorLineNr = { fg = colors.blue }

        hl.MatchParen = { underline = true, bold = true }
        hl.WinSeparator = { fg = colors.dark3 }
        hl.LspInlayHint = { fg = "#0db9d7", bg = "#203346", italic = true }
        hl.DiagnosticUnnecessary = { link = "NonText" }
        hl.CmpGhostText = { fg = "#567189", italic = true }

        -- fix bg of DiagnosticFloating (default is black)
        for _, diagType in ipairs({ "Error", "Warn", "Info", "Hint", "Ok" }) do
          hl["DiagnosticFloating" .. diagType] = hl["Diagnostic" .. diagType]
        end
      end,
      hide_inactive_statusline = true,
      dim_inactive = true,
      lualine_bold = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      {
        "linrongbin16/lsp-progress.nvim",
        opts = {},
      },
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
            vim.cmd([[hi clear StatusLine]]) -- clear weird color at the end of
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
            format = function(messages)
              if #messages > 0 then
                return table.concat(messages, " ")
              end
              local client_names = {}
              for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                if client and client.name ~= "" then
                  table.insert(client_names, 1, client.name)
                end
              end
              local result = table.concat(client_names, "")
              -- Truncate the result to the specified max_length
              local max_length = 50
              if #result > max_length then
                result = string.sub(result, 1, max_length) .. "..."
              end
              return result
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
    opts = function()
      local extras = {
        "CodeBlock",
        "Folded",
        "SignColumn",
        "FoldColumn",
      }
      for _, level in ipairs({ "INFO", "WARN", "ERROR", "DEBUG", "TRACE" }) do
        for _, name in ipairs({ "Body", "Title", "Border" }) do
          -- make these highlight NotifyINFOTitle,... transparent
          table.insert(extras, "Notify" .. level .. name)
        end
      end
      return {
        extra_groups = extras,
      }
    end,
  },
}
