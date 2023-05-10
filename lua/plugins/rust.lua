return {
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
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CargoCrates", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          local crates = require("crates")
          crates.show()
          local map = function(mode, key, func, desc)
            vim.keymap.set(mode, key, func, {
              silent = true,
              buffer = true,
              desc = desc,
            })
          end
          map("n", "ct", crates.toggle, "crates toggle")
          map("n", "cr", crates.reload, "crates reload")
          map("n", "cv", crates.show_versions_popup, "crates show version popup")
          map("n", "cf", crates.show_features_popup, "crates show features popup")
          map("n", "cd", crates.show_dependencies_popup, "crates show dependencies popup")
          map("n", "cu", crates.update_crate, "crates update")
          map("v", "cu", crates.update_crates, "crates update")
          map("n", "ca", crates.update_all_crates, "crates update all")
          map("n", "cU", crates.upgrade_crate, "crates upgrade")
          map("v", "cU", crates.upgrade_crates, "crates upgrade")
          map("n", "cA", crates.upgrade_all_crates, "crates upgrade all")
          map("n", "cH", crates.open_homepage, "crates open homepage")
          map("n", "cR", crates.open_repository, "crates open repository")
          map("n", "cD", crates.open_documentation, "crates open documentation")
          map("n", "cC", crates.open_crates_io, "crates open crates.io")
        end,
      })
    end,
    config = function()
      require("crates").setup()
    end,
  },
}
