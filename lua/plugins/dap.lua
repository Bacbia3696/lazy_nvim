return {
  "mfussenegger/nvim-dap",
  enabled = vim.fn.has("win32") == 0,
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "nvim-dap" },
      cmd = { "DapInstall", "DapUninstall" },
      opts = { handlers = {} },
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)

        -- experimental features:
        virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
      },
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        { "folke/neodev.nvim", opts = { library = { plugins = { "nvim-dap-ui" }, types = true } } },
      },
      opts = { floating = { border = "rounded" } },
      config = function(_, opts)
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
        dapui.setup(opts)
      end,
    },
  },
  init = function()
    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#c95959", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapBreakpointCondition", { ctermbg = 0, fg = "#ff8400", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define("DapBreakpointCondition", {
      text = "ﳁ",
      texthl = "DapBreakpointCondition",
      linehl = "DapBreakpointCondition",
      numhl = "DapBreakpointCondition",
    })
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapLogPoint",
      { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
    )
    vim.fn.sign_define(
      "DapStopped",
      { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
    )
  end,
  event = "User AstroFile",
}
