local function read_cmd(args)
  local ok, result = pcall(function()
    return vim.system(args, { text = true }):wait()
  end)
  if not ok or result.code ~= 0 then
    return ""
  end
  return (result.stdout:gsub("\n$", ""))
end

local render_quote = function()
  local cwd = vim.fn.getcwd()
  local folder_name = vim.fn.fnamemodify(cwd, ":t")
  local full_path = vim.fn.fnamemodify(cwd, ":~")

  local toilet_output = read_cmd({ "toilet", "-f", "future", "-F", "border", "-w", "100", folder_name })
  if toilet_output == "" then
    toilet_output = folder_name
  end

  local fortune_output = read_cmd({ "fortune" })
  if fortune_output == "" then
    fortune_output = "Let's build something amazing!"
  end

  local header = string.format(
    [[
%s

%s
----------------------------------------
%s
]],
    toilet_output,
    full_path,
    fortune_output
  )

  return {
    header = header,
    align = "center",
    padding = 2,
  }
end

local IMAGE_EXTS = {
  png = true, jpg = true, jpeg = true, gif = true, webp = true,
  bmp = true, svg = true, tiff = true, tif = true, ico = true, avif = true,
}

local URL_PATTERNS = {
  "https?://[%w_.~!*:@&+$,/%%#%-=?%[%]{}]+",
  "file://[%w_./%-]+",
  "/[%w_./%-]+%.(%a+)",
}

local is_image_url = function(url, ext)
  local url_ext = ext or url:match("%.(%a+)$")
  return url_ext and IMAGE_EXTS[url_ext:lower()]
end

local clean_url = function(url)
  return url:gsub("[)'\",;]+$", ""):gsub("^[['\"]+", "")
end

local get_url_on_line = function()
  local line = vim.api.nvim_get_current_line()
  for _, pat in ipairs(URL_PATTERNS) do
    local start = 1
    while true do
      local s, e, ext = line:find(pat, start)
      if not s then break end
      local url = clean_url(line:sub(s, e))
      if ext then
        if is_image_url(url, ext) then return url end
      elseif is_image_url(url) then
        return url
      end
      start = e + 1
    end
  end
end

local get_image_urls = function()
  local urls, seen = {}, {}
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for l, line in ipairs(lines) do
    local claimed = {}
    for _, pat in ipairs(URL_PATTERNS) do
      local start = 1
      while true do
        local s, e, ext = line:find(pat, start)
        if not s then break end
        local overlaps = false
        for _, r in ipairs(claimed) do
          if s <= r[2] and e >= r[1] then
            overlaps = true
            break
          end
        end
        if not overlaps then
          local url = clean_url(line:sub(s, e))
          if is_image_url(url, ext) and not seen[url] then
            seen[url] = true
            urls[#urls + 1] = { url = url, lnum = l }
          end
          claimed[#claimed + 1] = { s, e }
        end
        start = e + 1
      end
    end
  end
  return urls
end

local preview_all_images = function()
  local items = get_image_urls()
  if #items == 0 then return end
  for _, item in ipairs(items) do
    item.text = item.url
    item.file = item.url
    item.pos = { item.lnum, 0 }
  end
  Snacks.picker({
    source = "image_urls",
    items = items,
    format = function(item, _)
      local name = item.text:match("/([^/]+)$") or item.text
      return {
        { name, "SnacksPickerFile" },
        { " :" .. item.pos[1], "SnacksPickerComment" },
      }
    end,
    preview = function(ctx)
      ctx.preview:reset()
      ctx.preview:set_title(ctx.item.text:match("/([^/]+)$") or ctx.item.text)
      Snacks.image.buf.attach(ctx.buf, { src = ctx.item.text })
    end,
    confirm = function(picker, item)
      picker:close()
      vim.api.nvim_win_set_cursor(0, { item.pos[1], 0 })
    end,
  })
end

local preview_image = function()
  local text
  if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "\22" then
    vim.cmd('noau normal! "vy"')
    text = vim.trim(vim.fn.getreg("v"))
  else
    text = get_url_on_line()
    if not text then return end
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    width = 100,
    height = 20,
    col = 0,
    row = 0,
    style = "minimal",
    border = vim.g.border,
  })

  local placement = Snacks.image.placement.new(buf, text, {
    pos = { 1, 1 },
    auto_resize = true,
  })

  local close_preview = function()
    if placement then
      placement:close()
    end
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  vim.keymap.set("n", "q", close_preview, { buffer = buf })
  vim.keymap.set("n", "<esc>", close_preview, { buffer = buf })
end

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>i",
      preview_image,
      mode = { "n", "v" },
      desc = "Preview image (URL under cursor or visual selection)",
    },
    {
      "<leader>I",
      preview_all_images,
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
          builtin = false,
          cmd = { "delta" },
        },
        git = {
          builtin = false,
          args = {},
        },
      },
      ui_select = { enabled = true },
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
      },
    },
    dashboard = {
      sections = {
        render_quote,
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
