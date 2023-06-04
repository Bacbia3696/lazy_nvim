return {
  {
    "folke/noice.nvim",
    -- stylua: ignore
    keys = function(_, keys)
      -- use <C-d>, <C-u> instead of <C-f>, <C-b>
      keys[6] = {
        "<c-d>",
        function() if not require("noice.lsp").scroll(4) then return "<c-d>" end end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      }
      keys[7] = {
        "<c-u>",
        function() if not require("noice.lsp").scroll(-4) then return "<c-u>" end end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      }
    end,
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
        documentation = {
          view = "hover",
          ---@type NoiceViewOptions
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = { concealcursor = "n", conceallevel = 2 },
          },
        },
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
      -- format = {
      --   spinner = {
      --     ---@type Spinner
      --     name = "moon",
      --     hl_group = nil,
      --   },
      -- }, --- @see section on formatting
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
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "arkav/lualine-lsp-progress",
    },
    opts = function(_, opts)
      local auto_theme_custom = require("lualine.themes.auto")
      auto_theme_custom.normal.c.bg = "none"
      opts.options = {
        section_separators = { left = "", right = "" },
        theme = auto_theme_custom,
      }
      -- show lsp client instead of key
      opts.sections.lualine_x[1] = {
        "lsp_progress",
        timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 60000 },
        spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
      }
    end,
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    opts = {
      safe_output = true,
      separator = " ",
      highlight = false,
      depth_limit = 5,
      icons = require("lazyvim.config").icons.kinds,
    },
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
        surql = { icon = "", name = "Datbase" },
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
  {
    "xiyaowong/transparent.nvim",
    opts = {
      {
        extra_groups = {},
        exclude_groups = {}, -- table: groups you don't want to clear
      },
    },
  },
  { "lunarvim/synthwave84.nvim" },
  -- {
  --   "mini.animate",
  --   config = function(_, opts)
  --     opts.open = {
  --       enable = false,
  --     }
  --     opts.close = {
  --       enable = false,
  --     }
  --     require("mini.animate").setup(opts)
  --   end,
  -- },
}
