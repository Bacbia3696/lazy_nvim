return {
  {
    "folke/noice.nvim",
    keys = function(_, keys)
      -- use <C-d>, <C-u> instead of <C-f>, <C-b>
      keys[5] = {
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
      keys[6] = {
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
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        colors.border = "#565f89"
      end,
      style = "night",
      hide_inactive_statusline = true,
      dim_inactive = true,
      lualine_bold = true,
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
      deb = { icon = "", name = "Deb" },
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
    config = function(_, opts)
      require("nvim-web-devicons").set_default_icon("", "#6d8086", 65)
      require("nvim-web-devicons").set_icon(opts)
    end,
  },
}
