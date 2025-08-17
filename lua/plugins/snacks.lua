return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>i",
      function()
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
          border = "none",
        })

        -- Show image with auto-resize
        Snacks.image.placement.new(buf, text, {
          pos = { 1, 1 },
          auto_resize = true,
        })

        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = buf })
        vim.keymap.set("n", "<esc>", function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = buf })
      end,
      mode = "v",
      desc = "Preview selected image",
    },
  },
  opts = {
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
        function()
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
        end,
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
