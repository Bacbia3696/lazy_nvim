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
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "ga", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
      keys[#keys + 1] = { "go", vim.diagnostic.open_float, desc = "Line Diagnostics" }
      keys[#keys + 1] = { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" }
    end,
    opts = function(_, opts)
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
}
