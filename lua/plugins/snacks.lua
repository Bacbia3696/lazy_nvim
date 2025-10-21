local render_quote = function()
  local cwd = vim.fn.getcwd()
  local folder_name = vim.fn.fnamemodify(cwd, ":t")
  local full_path = vim.fn.fnamemodify(cwd, ":~")

  -- Generate figlet text
  local toilet_output = ""
  local handle = io.popen("toilet -f future -F border -w 100 '" .. folder_name .. "' 2>/dev/null")
  if handle then
    toilet_output = handle:read("*a")
    handle:close()
  end

  -- Fallback if figlet is not available
  if toilet_output == "" then
    toilet_output = folder_name
  else
    -- Remove trailing newline
    toilet_output = toilet_output:gsub("\n$", "")
  end

  -- Generate fortune quote
  local fortune_output = ""
  local fortune_handle = io.popen("fortune 2>/dev/null")
  if fortune_handle then
    fortune_output = fortune_handle:read("*a")
    fortune_handle:close()
    -- Remove trailing newline
    fortune_output = fortune_output:gsub("\n$", "")
  end

  -- Fallback if fortune is not available
  if fortune_output == "" then
    fortune_output = "Let's build something amazing! 🌟"
  end

  local header = string.format(
    [[
%s

📁 %s
----------------------------------------
🎯 %s
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

local preview_image = function()
  -- Get selected text
  vim.cmd('noau normal! "vy"')
  local text = vim.trim(vim.fn.getreg("v"))

  -- Create floating window
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

  -- Show image with auto-resize
  local placement = Snacks.image.placement.new(buf, text, {
    pos = { 1, 1 },
    auto_resize = true,
  })

  local close_preview = function()
    -- Close the placement first to clean up the image
    if placement then
      placement:close()
    end
    -- Then close the window and delete the buffer
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
      mode = "v",
      desc = "Preview selected image",
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
    },
    image = {
      enabled = true,
    },
    terminal = {
      win = {
        keys = {
          nav_j = false, -- C-j used to send newline character
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
            height = 0.55, -- Changed from 0.4 to 0.55 (55%)
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
        -- input window
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
