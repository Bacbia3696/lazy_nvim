return {
  { "Pocco81/HighStr.nvim" },
  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
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
          -- this is needed if I set custom treesitter queries
          -- opts = {
          --   win_options = { concealcursor = "n", conceallevel = 2 },
          -- },
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
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      on_highlights = function(hl, colors)
        -- hl.FoldColumn = { bg = colors.none, fg = colors.comment }
        -- hl.Folded = { bg = colors.none, fg = colors.comment }
        hl.SignColumn = { bg = colors.none }
        hl.WinBar = { bg = colors.none, bold = true, fg = colors.fg_dark }
        hl.WinBarNC = { bg = colors.none, italic = true, fg = colors.dark3 }
        hl.WinSeparator = { fg = colors.dark3 }
        hl.HelpviewInlineCodes = { link = "TablineSel" }
        hl.NvimDapVirtualText = { link = "DiagnosticVirtualTextHint" }
        hl.ComplHint = { fg = "#6178a8", italic = true }
        -- hl.BlinkCmpGhostText = { fg = colors.fg_dark, italic = true }
        hl.DiagnosticUnnecessary = { italic = true, fg = colors.fg_dark, undercurl = false }

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
    lazy = false,
    keys = {
      { "<leader>ut", "<Cmd>TransparentToggle<CR>", desc = "Toggle transparent" },
    },
    opts = function()
      local extras = {
        "CodeBlock",
        -- "Folded",
        -- "FoldColumn",
        "SignColumn",
        "WinBar",
        "WinBarNC",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
      }
      return {
        extra_groups = extras,
      }
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      focus = true,
    },
  },
}
