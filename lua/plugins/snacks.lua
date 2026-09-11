local function read_cmd(args, callback)
  if vim.fn.executable(args[1]) ~= 1 then
    return vim.schedule(function()
      callback("")
    end)
  end
  vim.system(args, { text = true }, function(result)
    vim.schedule(function()
      callback(result.code == 0 and (result.stdout or ""):gsub("\n$", "") or "")
    end)
  end)
end

local toilet_cache = {}
local fortune_cache
local dashboard_pending = 0

local function refresh_dashboard()
  if package.loaded["snacks.dashboard"] then
    Snacks.dashboard.update()
  end
end

local function load_dashboard_cmd(args, callback)
  dashboard_pending = dashboard_pending + 1
  read_cmd(args, function(out)
    callback(out)
    dashboard_pending = dashboard_pending - 1
    if dashboard_pending == 0 then
      refresh_dashboard()
    end
  end)
end

local render_quote = function()
  local cwd = vim.fn.getcwd()
  local folder_name = vim.fn.fnamemodify(cwd, ":t")
  local full_path = vim.fn.fnamemodify(cwd, ":~")

  if not toilet_cache[folder_name] then
    toilet_cache[folder_name] = folder_name
    load_dashboard_cmd({ "toilet", "-f", "future", "-F", "border", "-w", "100", folder_name }, function(out)
      if out ~= "" then
        toilet_cache[folder_name] = out
      end
    end)
  end

  if not fortune_cache then
    fortune_cache = "Let's build something amazing!"
    load_dashboard_cmd({ "fortune" }, function(out)
      if out ~= "" then
        fortune_cache = out
      end
    end)
  end

  local header = string.format(
    [[
%s

%s
----------------------------------------
%s
]],
    toilet_cache[folder_name],
    full_path,
    fortune_cache
  )

  return {
    header = header,
    align = "center",
    padding = 2,
  }
end

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>i",
      function()
        require("img_preview").preview_image()
      end,
      mode = { "n", "v" },
      desc = "Preview image (URL under cursor or visual selection)",
    },
    {
      "<leader>I",
      function()
        require("img_preview").preview_all_images()
      end,
      desc = "Preview all images in current buffer",
    },
  },
  opts = {
    styles = {
      terminal = {
        border = vim.g.border,
      },
      snacks_image = {
        border = vim.g.border,
      },
    },
    scroll = {
      enabled = true,
      animate = { duration = { step = 15, total = 100 } },
    },
    dim = {
      enabled = true,
    },
    zen = {
      toggles = {
        dim = false,
      },
      -- fixed for zen mode leetcode console, but error when git cli zen mode
      on_open = function(win)
        vim.schedule(function()
          vim.api.nvim_clear_autocmds({
            event = "WinEnter",
            group = win.augroup,
          })
          vim.api.nvim_create_autocmd("WinEnter", {
            group = win.augroup,
            callback = function()
              local w = vim.api.nvim_get_current_win()
              if w == win.win then
                return
              end
              if vim.api.nvim_win_is_valid(w) and vim.api.nvim_win_get_buf(w) == win.buf then
                vim.api.nvim_set_current_win(win.win)
              end
            end,
          })
        end)
      end,
    },
    image = {
      enabled = true,
    },
    terminal = {
      win = {
        keys = {
          nav_j = false,
        },
      },
    },
    picker = {
      layout = {
        preset = "ivy",
      },
      layouts = {
        ivy = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.55,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.6, border = "left" },
            },
          },
        },
      },
      win = {
        input = {
          keys = {
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          },
        },
      },
      previewers = {
        diff = {
          style = "terminal",
          cmd = { "delta" },
        },
      },
      ui_select = true,
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          follow = true,
          win = {
            list = {
              keys = {
                ["<C-l>"] = { "<C-w><C-l>", expr = true },
                ["<C-h>"] = { "<C-w><C-h>", expr = true },
              },
            },
          },
        },
        lsp_symbols = {
          layout = { preset = "ivy_split" },
        },
        lsp_references = {
          layout = { preset = "ivy_split" },
        },
      },
    },
    dashboard = {
      sections = {
        function()
          return render_quote()
        end,
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
