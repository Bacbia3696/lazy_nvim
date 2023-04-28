return {
  "mfussenegger/nvim-dap",
  -- stylua: ignore
  keys = {
    { "<F5>", require("dap").continue, desc = "Debugger: Continue" },
    { "<F9>", require("dap").toggle_breakpoint, desc = "Debugger: Toggle Breakpoint" },
    { "<F10>", require("dap").step_over, desc = "Debugger: Step Over" },
    { "<F33>", require("dap").clear_breakpoints, desc = "Debugger: Clear all breakpoints" }, -- C-F9
    { "<leader>df", function()
      local dapui = require("dapui")
        vim.ui.select({ "scopes", "stacks", "watches", "breakpoints", "repl", "console" }, {
          prompt = "DAP UI Element",
          format_item = function(item)
            return "Show: " .. item
          end,
        }, function(elem)
            dapui.float_element(elem)
          end)
    end, desc = "DapUI: Open floating window" },
  },
}
