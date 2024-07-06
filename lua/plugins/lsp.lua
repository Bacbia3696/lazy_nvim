return {
  {
    "folke/neoconf.nvim",
    opts = {
      local_settings = ".neoconf.json",
      global_settings = "neoconf.json",
      live_reload = true,
      filetype_jsonc = true,
      plugins = {
        lspconfig = {
          enabled = true,
        },
        jsonls = {
          enabled = true,
          configured_servers_only = false,
        },
        lua_ls = {
          enabled_for_neovim_config = true,
          enabled = true,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      require("lspconfig.ui.windows").default_options = {
        border = "rounded",
      }
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- table.insert(keys, { "gt", vim.lsp.buf.type_definition, desc = "Goto Type Definition" })
      table.insert(keys, {
        "gt",
        "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
      })
      table.insert(keys, {
        "<leader>tD",
        function()
          local enable = vim.b.virtual_text == nil and true or vim.b.virtual_text
          vim.b.virtual_text = not enable
          vim.diagnostic.show(nil, nil, nil, { virtual_text = vim.b.virtual_text })
        end,
        desc = "Toggle diagnostic virtual_text",
      })
    end,
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
      },
      diagnostics = {
        float = { border = "rounded" },
      },
      format = {
        timeout_ms = 5000,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = { border = "rounded", width = 0.8, height = 0.8 },
    },
  },
}
