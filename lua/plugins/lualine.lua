local mode_icons = {
  n = "󰆾",
  i = "󰏫",
  v = "󰈈",
  ["\22"] = "󰈈",
  V = "󰈈",
  c = "󰘳",
  no = "󰆾",
  s = "󰛔",
  S = "󰛔",
  ["\19"] = "󰛔",
  ic = "󰏫",
  R = "󰑕",
  Rv = "󰑕",
  cv = "󰘳",
  ce = "󰘳",
  r = "󰑕",
  rm = "󰑕",
  ["r?"] = "󰘳",
  ["!"] = "",
  t = "",
}

local function format_lsp(messages)
  local names = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })) do
    if client.name ~= "" then
      names[#names + 1] = client.name
    end
  end

  local status = table.concat(names, "")
  if #messages > 0 then
    status = status .. (status ~= "" and " " or "") .. table.concat(messages, " ")
  end
  return status
end

local function wider_than(width)
  return function()
    return vim.o.columns > width
  end
end

local function format_mode(mode)
  return (mode_icons[vim.fn.mode()] or "󰆾") .. " " .. mode:sub(1, 1)
end

local function macro_status()
  local register = vim.fn.reg_recording()
  return register ~= "" and "󰑋 Recording @" .. register or ""
end

local function lsp_progress()
  return require("lsp-progress").progress()
end

local function non_unix_file()
  return vim.bo.fileformat ~= "unix"
end

local function non_utf8_file()
  return vim.bo.fileencoding ~= "" and vim.bo.fileencoding ~= "utf-8"
end

local function position_status()
  local line = vim.fn.line(".")
  local total = vim.fn.line("$")
  local progress = total > 0 and math.floor(line / total * 100) or 0
  return string.format("%d%%%% %d:%d", progress, line, vim.fn.virtcol("."))
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    {
      "linrongbin16/lsp-progress.nvim",
      opts = {
        format = format_lsp,
      },
    },
  },
  opts = function(_, opts)
    local Util = require("lazyvim.util")
    local icons = require("lazyvim.config").icons
    local theme = require("lualine.themes.tokyonight")

    for _, mode in pairs(theme) do
      if mode.b then
        mode.b.bg = "none"
      end
      if mode.c then
        mode.c.bg = "none"
      end
    end

    local function endcap_color()
      local suffix = require("lualine.highlight").get_mode_suffix()
      local hl = vim.api.nvim_get_hl(0, { name = "lualine_a" .. suffix })
      return { fg = hl.bg and string.format("#%06x", hl.bg) or "none", bg = "none" }
    end

    local function endcap(symbol)
      return {
        function()
          return symbol
        end,
        color = endcap_color,
        padding = 0,
        separator = "",
      }
    end

    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      section_separators = { left = "", right = "" },
      component_separators = { left = "·", right = "·" },
      globalstatus = true,
      theme = theme,
      refresh = {
        statusline = 100,
      },
    })

    opts.sections.lualine_a = {
      {
        "mode",
        fmt = format_mode,
        separator = "",
      },
      endcap(""),
    }

    opts.sections.lualine_b = {
      {
        "branch",
        icon = "",
        cond = wider_than(70),
      },
      {
        Util.lualine.pretty_path({
          modified_sign = " ●",
          readonly_icon = "  ",
          length = 5,
        }),
      },
    }

    opts.sections.lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
        cond = wider_than(90),
      },
      {
        macro_status,
        color = "lualine_a_replace",
      },
    }

    opts.sections.lualine_x = {
      {
        lsp_progress,
        icon = { "", align = "right" },
      },
      {
        "fileformat",
        symbols = {
          unix = "",
          dos = "󰨮",
          mac = "󰀶",
        },
        padding = { left = 1, right = 0 },
        cond = non_unix_file,
      },
      {
        "fileencoding",
        padding = { left = 1, right = 1 },
        cond = non_utf8_file,
      },
    }

    opts.sections.lualine_y = {
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        cond = wider_than(80),
      },
    }

    opts.sections.lualine_z = {
      endcap(""),
      {
        position_status,
        padding = 1,
      },
    }

    return opts
  end,
}
