return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "OXY2DEV/helpview.nvim",
    ft = "help",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "Bekaboo/dropbar.nvim",
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
          update_events = {
            buf = {
              "FileChangedShellPost",
              "TextChanged",
              "ModeChanged",
            },
          },
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
    keys = function(_, keys)
      -- add <c-d> and <c-u> for noice preview scrolling
      return vim.list_extend(keys, {
        {
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
        },
        {
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
        },
      })
    end,
    opts = {
      cmdline = {
        view = "cmdline_popup",
        opts = {
          border = { style = vim.g.border, padding = { 0, 1 } },
          position = "50%",
          size = { width = 60 },
        },
      },
      lsp = {
        progress = { enabled = false },
        hover = {
          silent = true,
        },
        documentation = {
          view = "hover",
        },
      },
      messages = {
        view_error = "mini",
      },
      presets = {
        lsp_doc_border = true,
        bottom_search = false,
        command_palette = true,
      },
      views = {
        mini = { win_options = { winblend = 0 } },
        hover = { border = { padding = { 0, 0 } } },
        cmdline_popup = {
          border = { style = vim.g.border },
          position = { row = "50%", col = "50%" },
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
      on_highlights = function(hl, colors)
        hl.SignColumn = { bg = colors.none }
        hl.CursorLine = { bg = colors.bg_highlight }
        hl.CursorLineNr = { fg = colors.warning, bold = true }
        hl.LineNr = { fg = colors.dark3 }
        hl.StatusColumn = { bg = colors.none }
        hl.StatusLine = { bg = colors.none, fg = colors.fg }
        hl.StatusLineNC = { bg = colors.none, fg = colors.dark3 }
        hl.Folded = { bg = colors.bg_highlight, fg = colors.blue }
        hl.FoldColumn = { bg = colors.none, fg = colors.dark3 }
        hl.WinBar = { bg = colors.none, bold = true, fg = colors.fg_dark }
        hl.WinBarNC = { bg = colors.none, italic = true, fg = colors.dark3 }
        hl.WinSeparator = { fg = colors.dark3 }
        hl.NormalFloat = { bg = colors.none }
        hl.FloatBorder = { bg = colors.none, fg = colors.blue0 }
        hl.FloatTitle = { bg = colors.none, fg = colors.blue, bold = true }
        hl.Pmenu = { bg = colors.bg_dark, fg = colors.fg }
        hl.PmenuSel = { bg = colors.bg_highlight, fg = colors.fg, bold = true }
        hl.PmenuSbar = { bg = colors.bg_dark }
        hl.PmenuThumb = { bg = colors.blue0 }
        hl.MiniIndentscopeSymbol = { fg = colors.blue0, nocombine = true }
        hl.HelpviewInlineCodes = { link = "TablineSel" }
        hl.ComplHint = { fg = "#6178a8", italic = true }
        hl.DiagnosticUnnecessary = { italic = true, fg = colors.fg_dark, undercurl = false }
        hl.ColorColumn = { bg = colors.bg_highlight }

        for _, v in ipairs({ "Rare", "Cap", "Local", "Bad" }) do
          hl["Spell" .. v] = { undercurl = true }
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
    "xiyaowong/transparent.nvim",
    keys = {
      { "<leader>ut", "<Cmd>TransparentToggle<CR>", desc = "Toggle transparent" },
    },
    opts = {
      extra_groups = {
        "CodeBlock",
        "SignColumn",
        "StatusLine",
        "StatusLineNC",
        "WinBar",
        "WinBarNC",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {
      focus = true,
    },
  },
}
