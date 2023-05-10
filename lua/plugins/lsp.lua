return {
  {
    "tamago324/nlsp-settings.nvim",
    opts = {
      config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
      local_settings_dir = ".nlsp-settings",
      local_settings_root_markers_fallback = { ".git" },
      append_default_schemas = true,
      loader = "json",
    },
  },
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle" },
    init = function()
      require("telescope").load_extension("aerial")
    end,
    opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = { min_width = 28 },
      show_guides = true,
      filter_kind = false,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
      keymaps = {
        ["o"] = "actions.jump",
        ["{"] = "actions.prev",
        ["}"] = "actions.next",
        ["[["] = "actions.prev_up",
        ["]]"] = "actions.next_up",
        ["[y"] = false,
        ["]y"] = false,
        ["[Y"] = false,
        ["]Y"] = false,
        ["?"] = false,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    -- stylua: ignore
    init = function()
      require("lspconfig.ui.windows").default_options = {
        border = "rounded",
      }
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "ga", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
      keys[#keys + 1] = { "go", vim.diagnostic.open_float, desc = "Line Diagnostics" }
      keys[#keys + 1] = { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" }
      keys[#keys + 1] = { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" }
      keys[#keys + 1] = { "gL", vim.lsp.codelens.refresh, desc = "LSP CodeLens refresh" }
      keys[#keys + 1] = { "gl", vim.lsp.codelens.run, desc = "LSP CodeLens run" }
      keys[#keys + 1] = { "[D", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
        desc = "diagnostic goto prev ERROR" }
      keys[#keys + 1] = { "]D", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
        desc = "diagnostic goto prev ERROR" }
      keys[#keys + 1] = { "cc", "<cmd>LspRestart<cr>", desc = "Lsp restart" }

      -- add codelens for on_attach function
      require("lazyvim.util").on_attach(function(client, _)
        local capabilities = client.server_capabilities
        if capabilities.codeLensProvider then
          vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter" }, {
            group = Augroup("lsp_codelens_refresh"),
            callback = function()
              if vim.g.codelens_enabled then
                vim.lsp.codelens.refresh()
              end
            end,
          })
          -- NOTE: this is quite hacky, because we cann't call codelens in the begining
          vim.fn.timer_start(100, vim.lsp.codelens.refresh, { ["repeat"] = 5 })
        end
      end)
    end,
    opts = function(_, opts)
      opts.diagnostics.virtual_text = { spacing = 4, prefix = "●", source = true }
      opts.diagnostics.float = { border = "rounded" }
      opts.autoformat = false
      opts.format = {
        formatting_options = nil,
        timeout_ms = 5000,
      }
      -- opts.servers["sqlls"] = {
      --   settings = {
      --     sqlLanguageServer = {
      --       connections = {
      --         {
      --           name = "postgres_project",
      --           adapter = "postgres",
      --           host = "127.0.0.1",
      --           port = 5432,
      --           user = "nguyenthanhdat",
      --           database = "postgres",
      --         },
      --       },
      --     },
      --   },
      -- }
      opts.servers["tailwindcss"] = {}
      opts.servers["gopls"] = {
        settings = {
          gopls = {
            codelenses = {
              generate = true,
              gc_details = true,
              upgrade_dependency = true,
              tidy = true,
              vendor = false,
            },
            analyses = {
              unusedparams = true,
              -- composites = false,
              nilness = true,
              unusedwrite = true,
              useany = true,
              unusedvariable = true,
              fieldalignment = false,
              shadow = true,
            },
            -- usePlaceholders = true,
          },
        },
      }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    opts = {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {},
    },
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    event = { "BufRead Cargo.toml" },
    opts = {
      server = {
        cmd = { "rustup", "run", "nightly", "rust-analyzer" },
        settings = {
          ["rust-analyzer"] = {
            assist = { expressionFillDefault = "default" },
            cargo = {
              allFeatures = true,
              buildScripts = { enable = true },
            },
            -- hover = { actions = { references = { enable = true } } },
            inlayHints = { locationLinks = true },
            diagnostics = {
              enable = true,
              experimental = { enable = true },
              disabled = { "unresolved-proc-macro" },
            },
            -- use check by clippy is too slow
            -- check = {
            --   command = "clippy",
            --   extraArgs = {
            --     "--",
            --     "-A",
            --     "clippy::uninlined_format_args",
            --   },
            -- },
          },
        },
      },
      -- tools = { hover_actions = { auto_focus = true } },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ui = { border = "rounded", width = 0.8, height = 0.8 } },
  },
}
