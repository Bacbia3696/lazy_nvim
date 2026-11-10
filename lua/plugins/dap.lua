return {
  { "rcarriga/nvim-dap-ui", enabled = false },
  -- nvim-dap-go already provides the Go configurations
  { "jay-babu/mason-nvim-dap.nvim", opts = { handlers = { delve = function() end } } },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      -- opts, not config: LazyVim's dap extra owns nvim-dap's config (signs, launch.json).
      local dap = require("dap")
      local last_port = "38697"

      dap.adapters.go_headless = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port })
      end

      dap.configurations.go = dap.configurations.go or {}
      table.insert(dap.configurations.go, {
        type = "go_headless",
        name = "Attach to headless dlv",
        request = "attach",
        mode = "remote",
        host = "127.0.0.1",
        port = function()
          return coroutine.create(function(dap_run_co)
            vim.ui.input({ prompt = "dlv port: ", default = last_port }, function(input)
              local port = tonumber(input or "")
              if port then
                last_port = tostring(port)
              end
              coroutine.resume(dap_run_co, port or dap.ABORT)
            end)
          end)
        end,
      })
    end,
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        init = function()
          local augroup = vim.api.nvim_create_augroup("dap_view_q_close", { clear = true })
          vim.api.nvim_create_autocmd({ "FileType" }, {
            group = augroup,
            pattern = { "dap-view", "dap-view-term", "dap-repl" }, -- dap-repl is set by `nvim-dap`
            callback = function(evt)
              vim.keymap.set("n", "q", "<C-w>q", { buffer = evt.buf })
            end,
          })
        end,
        opts = {
          auto_toggle = true,
          winbar = {
            default_section = "scopes",
          },
          windows = {
            position = "right",
            size = 0.35,
            terminal = {
              size = 0.3,
              position = "below",
              -- No terminal pane for delve flavors: dap-view creates none,
              -- and remote dlv output lives in the shell that launched it.
              hide = { "go", "go_headless", "delve", "node", "pwa-node" },
            },
          },
        },
        keys = {
          { "<leader>dd", "<cmd>DapViewToggle<cr>", desc = "Toggle DAP View" },
          { "<leader>de", "<cmd>DapViewHover<cr>", desc = "Eval" },
          { "<leader>de", ":DapViewHover<cr>", mode = "x", desc = "Eval" },
          { "<leader>dW", "<cmd>DapViewWatch<cr>", desc = "Add Watch" },
          { "<leader>dW", ":DapViewWatch<cr>", mode = "x", desc = "Add Watch" },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>dn", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dv", "<cmd>DapVirtualTextToggle<cr>", desc = "Toggle Virtual Text" },
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Run/Continue" },
      { "<S-F5>", function() require("dap").terminate() end, desc = "Debug: Terminate" },
      { "<leader>dD", function() require("dap").disconnect({ terminateDebuggee = false }) end, desc = "Detach (keep process running)" },
      { "<F9>",function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
    },
  },
}
