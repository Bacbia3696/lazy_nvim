return {
  { "rcarriga/nvim-dap-ui", enabled = false },
  {
    "mfussenegger/nvim-dap",
    init = function()
      -- init, not config: LazyVim's dap extra owns nvim-dap's config (signs, launch.json).
      local dap = require("dap")
      local last_port = "38697"

      dap.adapters.go_headless = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port })
      end

      dap.configurations.go = dap.configurations.go or {}
      local exists = false
      for _, c in ipairs(dap.configurations.go) do
        if c.name == "Attach to headless dlv" then
          exists = true
          break
        end
      end
      if not exists then
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
      end
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
          winbar = {
            default_section = "scopes",
          },
          windows = {
            terminal = {
              size = 0.3,
              position = "right",
              -- No terminal pane for delve flavors: dap-view creates none,
              -- and remote dlv output lives in the shell that launched it.
              hide = { "go", "go_headless", "delve", "node", "pwa-node" },
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
          local id = "dapview_config"
          dap.listeners.after.event_initialized[id] = dapview.open
          dap.listeners.before.event_terminated[id] = dapview.close
          dap.listeners.before.event_exited[id] = dapview.close
        end,
      },
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
}
