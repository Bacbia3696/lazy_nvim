return {
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
          -- NOTE: this is quite hacky, because we can call codelens in the begining
          vim.fn.timer_start(100, vim.lsp.codelens.refresh, { ["repeat"] = 5 })
        end
      end)
    end,
    opts = function(_, opts)
      opts.diagnostics.virtual_text = { spacing = 4, prefix = "●", source = true }
      opts.diagnostics.float = { border = "rounded" }
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
      ensure_installed = {
        "goimports",
      },
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
            hover = { actions = { references = { enable = true } } },
            inlayHints = { locationLinks = true },
            diagnostics = {
              enable = true,
              experimental = { enable = true },
              disabled = { "unresolved-proc-macro" },
            },
            check = {
              command = "clippy",
              extraArgs = {
                "--",
                "-A",
                "clippy::uninlined_format_args",
              },
            },
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
