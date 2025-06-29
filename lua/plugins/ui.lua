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
        hl.FoldColumn = { bg = colors.none, fg = colors.comment }
        hl.SignColumn = { bg = colors.none }
        hl.WinBar = { bg = colors.none, bold = true, fg = colors.fg_dark }
        hl.WinBarNC = { bg = colors.none, italic = true, fg = colors.dark3 }
        hl.WinSeparator = { fg = colors.dark3 }
        hl.HelpviewInlineCodes = { link = "TablineSel" }
        hl.NvimDapVirtualText = { link = "DiagnosticVirtualTextHint" }
        hl.BlinkCmpGhostText = { fg = colors.fg_dark, italic = true }
        hl.CmpGhostText = { fg = "#444a73", italic = true }
        hl.DiagnosticUnnecessary = { italic = true, fg = colors.fg_dark, undercurl = true }

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
        { Util.lualine.pretty_path({ relative = "root", modified_sign = " ", length = 2 }) },
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
      -- replace key with lsp progress (maybe 2 or 3 depend on copilot enable or not)
      opts.sections.lualine_x[2] = {
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
          -- component_separators = { left = "", right = "" },
          theme = auto_theme_custom,
        },
      })
    end,
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
        "Folded",
        "SignColumn",
        "FoldColumn",
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
