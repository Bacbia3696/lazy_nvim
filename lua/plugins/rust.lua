return {
  {
    "simrat39/rust-tools.nvim",
    opts = {
      tools = {
        inlay_hints = {
          auto = false,
        },
      },
    },
  },
  {
    "Saecki/crates.nvim",
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CargoCrates", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          local crates = require("crates")
          local map = function(mode, key, func, desc)
            vim.keymap.set(mode, key, func, {
              silent = true,
              buffer = true,
              desc = desc,
            })
          end
          require("which-key").register({ ["<C-c>"] = { name = "crates " } }, {})

          map("n", "<C-c>t", crates.toggle, "toggle")
          map("n", "<C-c>r", crates.reload, "reload")
          map("n", "<C-c>v", crates.show_versions_popup, "show version popup")
          map("n", "<C-c>k", crates.show_popup, "show crate popup")
          map("n", "<C-c>f", crates.show_features_popup, "show features popup")
          map("n", "<C-c>d", crates.show_dependencies_popup, "show dependencies popup")
          map("n", "<C-c>u", crates.update_crate, "update")
          map("v", "<C-c>u", crates.update_crates, "update")
          map("n", "<C-c>a", crates.update_all_crates, "update all")
          map("n", "<C-c>U", crates.upgrade_crate, "upgrade")
          map("v", "<C-c>U", crates.upgrade_crates, "upgrade")
          map("n", "<C-c>A", crates.upgrade_all_crates, "upgrade all")
          map("n", "<C-c>H", crates.open_homepage, "open homepage")
          map("n", "<C-c>R", crates.open_repository, "open repository")
          map("n", "<C-c>D", crates.open_documentation, "open documentation")
          map("n", "<C-c>C", crates.open_crates_io, "open crates.io")
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
