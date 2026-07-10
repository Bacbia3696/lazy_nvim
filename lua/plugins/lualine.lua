return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    {
      "linrongbin16/lsp-progress.nvim",
      opts = {
        format = function(messages)
          if #messages > 0 then
            return table.concat(messages, " ")
          end
          local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
          local names = {}
          for _, client in ipairs(clients) do
            if client.name ~= "" then
              table.insert(names, 1, client.name)
            end
          end
          return table.concat(names, "")
        end,
      },
    },
  },
  opts = function(_, opts)
    local Util = require("lazyvim.util")
    local icons = require("lazyvim.config").icons

    -- Mode icons for a more beautiful statusline
    local mode_icons = {
      n = "󰆾", -- NORMAL
      i = "󰏫", -- INSERT
      v = "󰈈", -- VISUAL
      ["\22"] = "󰈈", -- VISUAL BLOCK
      V = "󰈈", -- VISUAL LINE
      c = "󰘳", -- COMMAND
      no = "󰆾", -- OPERATOR-PENDING
      s = "󰛔", -- SELECT
      S = "󰛔", -- SELECT LINE
      ["\19"] = "󰛔", -- SELECT BLOCK
      ic = "󰏫", -- INSERT COMPLETION
      R = "󰑕", -- REPLACE
      Rv = "󰑕", -- VIRTUAL REPLACE
      cv = "󰘳", -- EX
      ce = "󰘳", -- NORMAL EX
      r = "󰑕", -- HIT-ENTER
      rm = "󰑕", -- MORE
      ["r?"] = "󰘳", -- CONFIRM
      ["!"] = "", -- SHELL
      t = "", -- TERMINAL
    }

    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      globalstatus = true,
      refresh = {
        statusline = 100,
      },
    })

    -- Section A: Mode with icon
    opts.sections.lualine_a = {
      {
        "mode",
        fmt = function(str)
          local mode = vim.fn.mode()
          local icon = mode_icons[mode] or "󰆾"
          return icon .. " " .. str:sub(1, 1)
        end,
      },
    }

    -- Section B: Root dir → File path → Filetype icon → Diagnostics
    opts.sections.lualine_b = {
      Util.lualine.root_dir(),
      {
        Util.lualine.pretty_path({
          modified_sign = " ●",
          readonly_icon = "  ",
          length = 5,
        }),
      },
      {
        "filetype",
        icon_only = true,
        separator = "",
        padding = { left = 1, right = 0 },
      },
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

    -- Section C: Empty (reserve for macro recording, search count, etc.)
    opts.sections.lualine_c = {
      {
        "macro",
        fmt = function()
          local reg = vim.fn.reg_recording()
          if reg ~= "" then
            return "󰑋 Recording @" .. reg
          end
          return ""
        end,
        color = "lualine_a_replace",
        draw_empty = false,
      },
    }

    -- Section X: LSP progress → File format/encoding (when not utf-8/unix)
    opts.sections.lualine_x = {
      {
        function()
          return require("lsp-progress").progress()
        end,
        icon = { "", align = "right" },
      },
      {
        "fileformat",
        symbols = {
          unix = "",
          dos = "󰨮",
          mac = "󰀶",
        },
        separator = "",
        padding = { left = 1, right = 0 },
        cond = function()
          return vim.bo.fileformat ~= "unix"
        end,
      },
      {
        "fileencoding",
        separator = "",
        padding = { left = 1, right = 1 },
        cond = function()
          return vim.bo.fileencoding ~= "" and vim.bo.fileencoding ~= "utf-8"
        end,
      },
    }

    -- Section Y: Git branch + diff stats
    opts.sections.lualine_y = {
      {
        "branch",
        icon = "",
      },
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        cond = function()
          return vim.o.columns > 80
        end,
      },
    }

    -- Section Z: Progress → Location → Timer → Pomodoro
    opts.sections.lualine_z = {
      { "progress", separator = "", padding = 1 },
      { "location", separator = "", padding = 1 },
      {
        function()
          local t = require("timers.manager").get_closest_timer()
          if not t then
            return ""
          end
          local status_icon = ""
          if t:paused() then
            status_icon = "⏸ "
          else
            local ok, spinner = pcall(require, "noice.util.spinners")
            if ok then
              status_icon = spinner.spin("aesthetic") .. " "
            end
          end
          return t.icon .. " " .. status_icon .. t:expire_in():into_hms()
        end,
        color = function()
          local t = require("timers.manager").get_closest_timer()
          if not t then
            return nil
          end
          local sec = t:expire_in():asSeconds()
          return sec < 60 and "lualine_a_replace" or sec < 300 and "lualine_a_command" or "lualine_a_terminal"
        end,
        separator = { left = "", right = "" },
      },
      {
        function()
          local t = require("timers.manager").get_closest_timer()
          if t and _G.pomodoro_count and _G.pomodoro_count > 0 then
            return "🍅×" .. _G.pomodoro_count
          end
          return ""
        end,
        color = "lualine_a_visual",
        separator = { left = "", right = "" },
      },
    }

    -- Inactive windows: simpler, dimmer
    opts.inactive_sections = opts.inactive_sections or {}
    opts.inactive_sections.lualine_a = {}
    opts.inactive_sections.lualine_b = {
      { "filename", path = 1, symbols = { modified = " ●", readonly = " " } },
    }
    opts.inactive_sections.lualine_c = {}
    opts.inactive_sections.lualine_x = {}
    opts.inactive_sections.lualine_y = {}
    opts.inactive_sections.lualine_z = { "location" }

    return opts
  end,
}
