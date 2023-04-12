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
    config = function(_, opts)
      local rt = require("rust-tools")
      rt.setup(opts)
      require("lazyvim.util").on_attach(function(client, bufnr)
        if client.name == "rust_analyzer" then
          vim.keymap.set("n", "<S-k>", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "LSP hover actions" })
        end
      end)
    end,
    opts = {
      server = {
        cmd = { "rustup", "run", "nightly", "rust-analyzer" },
        settings = {
          ["rust-analyzer"] = {
            assist = { expressionFillDefault = "default" },
            cargo = {
              allFeatures = true,
              -- buildScripts = { enable = true },
            },
            -- hover = { actions = { references = { enable = true } } },
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
      tools = { hover_actions = { auto_focus = true } },
    },
  },
}
