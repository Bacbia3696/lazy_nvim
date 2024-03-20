return {
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
