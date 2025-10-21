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
          local client_names = {}
          local bufnr = vim.api.nvim_get_current_buf()
          local clients = vim.lsp.get_clients()
          for _, client in ipairs(clients) do
            if client and client.name ~= "" and vim.lsp.buf_is_attached(bufnr, client.id) then
              table.insert(client_names, 1, client.name)
            end
          end
          return table.concat(client_names, "")
        end,
      },
    },
  },
  opts = function(_, opts)
    local Util = require("lazyvim.util")
    local icons = require("lazyvim.config").icons

    -- show lsp client instead of key
    opts.sections.lualine_b = {
      Util.lualine.root_dir(),
      { Util.lualine.pretty_path({ modified_sign = " ", length = 5 }) },
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
    -- replace key with lsp progress (maybe 2 or 4 depend on copilot enable or not)
    opts.sections.lualine_x[4] = {
      -- Show lsp info
      function()
        return require("lsp-progress").progress()
      end,
      icon = { "", align = "right" },
    }
    opts.sections.lualine_y = { "branch" }
    opts.sections.lualine_z = {
      { "progress" },
      { "location", separator = "" },
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
      },
      {
        function()
          local t = require("timers.manager").get_closest_timer()
          -- Only show pomodoro count when there's an active timer and count > 0
          if t and _G.pomodoro_count and _G.pomodoro_count > 0 then
            return "🍅×" .. _G.pomodoro_count
          end
          return ""
        end,
        color = "lualine_a_visual",
      },
    }
    return vim.tbl_deep_extend("force", opts, {
      options = {
        section_separators = { left = "", right = "" },
        refresh = {
          statusline = 100,
        },
      },
    })
  end,
}
