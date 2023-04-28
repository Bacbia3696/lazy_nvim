return {
  {
    "folke/noice.nvim",
    -- stylua: ignore
    keys = function(_, keys)
      -- use <C-d>, <C-u> instead of <C-f>, <C-b>
      keys[6] = { "<c-d>", function() if not require("noice.lsp").scroll(4) then return "<c-d>" end end, silent = true, expr = true, desc = "Scroll forward", mode = { "i", "n", "s" }, }
      keys[7] = { "<c-u>", function() if not require("noice.lsp").scroll(-4) then return "<c-u>" end end, silent = true, expr = true, desc = "Scroll backward", mode = { "i", "n", "s" }, }
    end,
    config = {
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
  { "rcarriga/nvim-notify", opts = {
    top_down = false,
  } },
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        colors.bg = colors.bg_dark
      end,
      on_highlights = function(hl, colors)
        hl.NeoTreeNormal = { bg = colors.bg }
        hl.FoldColumn = { bg = colors.none, fg = colors.comment }
        hl.SignColumn = { bg = colors.none }
        hl.WinSeparator = { link = "FloatBorder" }
        hl.DiagnosticUnnecessary = { link = "NonText" }
      end,
      -- style = "night",
      hide_inactive_statusline = true,
      dim_inactive = false,
      lualine_bold = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = {
        section_separators = { left = "", right = "" },
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
        lock = { icon = "", name = "Lock" },
        mp3 = { icon = "", name = "Mp3" },
        mp4 = { icon = "", name = "Mp4" },
        out = { icon = "", name = "Out" },
        ["robots.txt"] = { icon = "ﮧ", name = "Robots" },
        ttf = { icon = "", name = "TrueTypeFont" },
        rpm = { icon = "", name = "Rpm" },
        woff = { icon = "", name = "WebOpenFontFormat" },
        woff2 = { icon = "", name = "WebOpenFontFormat2" },
        xz = { icon = "", name = "Xz" },
        zip = { icon = "", name = "Zip" },
      },
    },
  },
}
