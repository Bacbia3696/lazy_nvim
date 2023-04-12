return {
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      -- add your options that should be passed to the setup() function here
      position = "right",
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
