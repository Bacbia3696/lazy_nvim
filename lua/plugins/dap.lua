return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "igorlfs/nvim-dap-view",
      init = function()
        vim.api.nvim_create_autocmd({ "FileType" }, {
          pattern = { "dap-view", "dap-view-term", "dap-repl" }, -- dap-repl is set by `nvim-dap`
          callback = function(evt)
            vim.keymap.set("n", "q", "<C-w>q", { buffer = evt.buf })
          end,
        })
      end,
      opts = {
        winbar = {
          default_section = "scopes",
        },
        windows = {
          terminal = {
            width = 0.3,
            position = "right",
            -- List of debug adapters for which the terminal should be ALWAYS hidden
            hide = { "go", "node", "pwa-node" },
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
