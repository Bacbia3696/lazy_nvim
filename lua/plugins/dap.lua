return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<F5>",  require("dap").continue,          desc = "Debugger: Continue" },
      { "<F9>",  require("dap").toggle_breakpoint, desc = "Debugger: Toggle Breakpoint" },
      { "<F10>", require("dap").step_over,         desc = "Debugger: Step Over" },
      { "<F11>", require("dap").step_into,         desc = "Debugger: Step Into" },
      { "<F33>", require("dap").clear_breakpoints, desc = "Debugger: Clear all breakpoints" }, -- C-F9
      {
        "<leader>df",
        function()
          local dapui = require("dapui")
          vim.ui.select({ "scopes", "stacks", "watches", "breakpoints", "repl", "console" }, {
            prompt = "DAP UI Element",
            format_item = function(item)
              return "Show: " .. item
            end,
          }, function(elem)
            dapui.float_element(elem)
          end)
        end,
        desc = "DapUI: Open floating window"
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      {
        "leoluz/nvim-dap-go",
        opts = {
          delve = {
            initialize_timeout_sec = 60,
          },
        },
        config = function()
          require("dap-go").setup()
        end,
      },
    },
    opts = {
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}
