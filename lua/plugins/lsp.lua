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
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- table.insert(keys, { "gt", vim.lsp.buf.type_definition, desc = "Goto Type Definition" })
      table.insert(keys, {
        "gt",
        "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
      })
    end,
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        float = { border = vim.g.border },
        virtual_text = false,
      },
      format = {
        timeout_ms = 5000,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = { border = vim.g.border, width = 0.8, height = 0.8 },
    },
  },
}
