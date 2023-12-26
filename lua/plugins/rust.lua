return {
  { "simrat39/rust-tools.nvim", enabled = false },
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(client, bufnr)
          -- register which-key mappings
          local wk = require("which-key")
          wk.register({
            ["<leader>cR"] = {
              function()
                vim.cmd.RustLsp("codeAction")
              end,
              "Code Action",
            },
            ["<leader>dr"] = {
              function()
                vim.cmd.RustLsp("debuggables")
              end,
              "Rust debuggables",
            },
          }, { mode = "n", buffer = bufnr })
        end,
        settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {},
        taplo = {
          keys = {
            {
              "K",
              function()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
      },
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
  {
    "Saecki/crates.nvim",
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = require("helpers").augroup("CargoCrates"),
        pattern = "Cargo.toml",
        callback = function()
          local crates = require("crates")
          local map = require("helpers").map
          require("which-key").register({ ["<localleader>"] = { name = "crates " } }, {})

          map("n", "<localleader>t", crates.toggle, { desc = "toggle" })
          map("n", "<localleader>r", crates.reload, { desc = "reload" })
          map("n", "<localleader>v", crates.show_versions_popup, { desc = "show version popup" })
          map("n", "<localleader>k", crates.show_popup, { desc = "show crate popup" })
          map("n", "<localleader>f", crates.show_features_popup, { desc = "show features popup" })
          map("n", "<localleader>d", crates.show_dependencies_popup, { desc = "show dependencies popup" })
          map("n", "<localleader>u", crates.update_crate, { desc = "update" })
          map("v", "<localleader>u", crates.update_crates, { desc = "update" })
          map("n", "<localleader>a", crates.update_all_crates, { desc = "update all" })
          map("n", "<localleader>U", crates.upgrade_crate, { desc = "upgrade" })
          map("v", "<localleader>U", crates.upgrade_crates, { desc = "upgrade" })
          map("n", "<localleader>A", crates.upgrade_all_crates, { desc = "upgrade all" })
          map("n", "<localleader>H", crates.open_homepage, { desc = "open homepage" })
          map("n", "<localleader>R", crates.open_repository, { desc = "open repository" })
          map("n", "<localleader>D", crates.open_documentation, { desc = "open documentation" })
          map("n", "<localleader>C", crates.open_crates_io, { desc = "open crates.io" })
        end,
      })
    end,
    opts = {
      popup = {
        autofocus = true,
        border = "rounded",
      },
    },
  },
}
