return {
  "folke/snacks.nvim",
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
    picker = {
      ui_select = { enabled = true },
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          follow = true,
        },
      },
    },
  },
}
