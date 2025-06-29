return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "igorlfs/nvim-dap-view",
      opts = {
        windows = {
          terminal = {
            hide = { "go" },
          },
        },
      },
      keys = {
        { "<leader>dd", "<cmd>DapViewToggle<cr>", desc = "Toggle DAP View" },
      },
      config = function(_, opts)
        local dap = require("dap")
        local dapview = require("dap-view")
        dapview.setup(opts)
        dap.listeners.after.event_initialized["dapview_config"] = function()
          dapview.open()
        end
        dap.listeners.before.event_terminated["dapview_config"] = function()
          dapview.close()
        end
        dap.listeners.before.event_exited["dapview_config"] = function()
          dapview.close()
        end
      end,
    },
    keys = {
      {
        "<leader>dn",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    enabled = false,
  },
}
