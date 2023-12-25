return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    enabled = false,
    config = function()
      local rainbow = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          tsx = "rainbow-parens",
        },
      }
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = function()
      local utils = require("dropbar.utils")
      local sources = require("dropbar.sources")
      local filename = {
        get_symbols = function(buff, win, cursor)
          local symbols = sources.path.get_symbols(buff, win, cursor)
          return { symbols[#symbols] }
        end,
      }
      return {
        bar = {
          sources = function(buf, _)
            if vim.bo[buf].ft == "markdown" then
              return {
                sources.path,
                sources.markdown,
              }
            end
            if vim.bo[buf].buftype == "terminal" then
              return {
                sources.terminal,
              }
            end
            return {
              filename,
              utils.source.fallback({
                sources.lsp,
                sources.treesitter,
              }),
            }
          end,
        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    -- stylua: ignore
    keys = function(_, keys)
      -- use <c-d> and <c-u> for scrolling
      keys[6] = { "<c-d>", function() if not require("noice.lsp").scroll(4) then return "<c-d>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} }
      keys[7] = { "<c-u>", function() if not require("noice.lsp").scroll(-4) then return "<c-u>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}}
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
      top_down = true,
      stages = "slide",
      render = "compact",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, colors)
        hl.FoldColumn = { bg = colors.none, fg = colors.comment }
        hl.SignColumn = { bg = colors.none }

        hl.LineNr = { fg = colors.dark3 }
        hl.CursorLineNr = { fg = colors.blue }
        hl.StatusLineNC = { fg = colors.dark3 } -- more clear color for winbar when clicked

        hl.MatchParen = { underline = true, bold = true }
        hl.WinSeparator = { fg = colors.dark3 }
        hl.LspInlayHint = { fg = "#0db9d7", bg = "#203346", italic = true }
        hl.DiagnosticUnnecessary = { link = "NonText" }
        hl.CmpGhostText = { fg = "#567189", italic = true }
        hl.Todo = { bold = true }
        hl.WinBar = { bg = colors.none, bold = true, fg = colors.fg_dark }
        hl.WinBarNC = { bg = colors.none, italic = true, fg = colors.dark3 }

        -- fix bg of DiagnosticFloating (default is black)
        for _, diagType in ipairs({ "Error", "Warn", "Info", "Hint", "Ok" }) do
          hl["DiagnosticFloating" .. diagType] = hl["Diagnostic" .. diagType]
        end
      end,
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
      -- auto_theme_custom.normal.b.bg = "none"
      -- show lsp client instead of key
      opts.sections.lualine_b = {
        Util.lualine.root_dir(),
        { Util.lualine.pretty_path() },
        -- { "filetype", icon_only = true, separator = "" },
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
      opts.sections.lualine_c = {}
      opts.sections.lualine_x[1] = {
        -- Show lsp info
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
              return table.concat(client_names, "")
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
      return vim.tbl_deep_extend("force", opts, {
        options = {
          section_separators = { left = "", right = "" },
          theme = auto_theme_custom,
        },
      })
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    opts = function()
      local extras = {
        "CodeBlock",
        "Folded",
        "SignColumn",
        "FoldColumn",
        "WinBar",
        "WinBarNC",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
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
