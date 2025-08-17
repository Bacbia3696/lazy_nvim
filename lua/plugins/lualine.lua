return {
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

    -- show lsp client instead of key
    opts.sections.lualine_b = {
      Util.lualine.root_dir(),
      { Util.lualine.pretty_path({ relative = "root", modified_sign = " ", length = 3 }) },
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
      },
    })
  end,
}
