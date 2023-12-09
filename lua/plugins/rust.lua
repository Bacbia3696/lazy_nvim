return {
  {
    "simrat39/rust-tools.nvim",
    opts = {
      tools = {
        inlay_hints = {
          auto = false,
        },
        on_initialized = function()
          vim.cmd([[
            augroup RustLSP
              autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
              " autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
            augroup END
          ]])
        end,
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
          local map = require("custom.helpers").map
          require("which-key").register({ ["<localleader>"] = { name = "crates " } }, {})

          map("n", "<localleader>t", crates.toggle, "toggle")
          map("n", "<localleader>r", crates.reload, "reload")
          map("n", "<localleader>v", crates.show_versions_popup, "show version popup")
          map("n", "<localleader>k", crates.show_popup, "show crate popup")
          map("n", "<localleader>f", crates.show_features_popup, "show features popup")
          map("n", "<localleader>d", crates.show_dependencies_popup, "show dependencies popup")
          map("n", "<localleader>u", crates.update_crate, "update")
          map("v", "<localleader>u", crates.update_crates, "update")
          map("n", "<localleader>a", crates.update_all_crates, "update all")
          map("n", "<localleader>U", crates.upgrade_crate, "upgrade")
          map("v", "<localleader>U", crates.upgrade_crates, "upgrade")
          map("n", "<localleader>A", crates.upgrade_all_crates, "upgrade all")
          map("n", "<localleader>H", crates.open_homepage, "open homepage")
          map("n", "<localleader>R", crates.open_repository, "open repository")
          map("n", "<localleader>D", crates.open_documentation, "open documentation")
          map("n", "<localleader>C", crates.open_crates_io, "open crates.io")
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
