return {
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- optional
    },
    version = "1.x.x", -- recommended
  },
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
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "AerialToggle" },
      { "<leader>cS", "<cmd>AerialNavToggle<cr>", desc = "AerialToggle" },
    },
    init = function()
      require("telescope").load_extension("aerial")
    end,
    opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = {
        min_width = 20,
        max_width = { 50, 0.3 },
        placement = "edge",
        preserve_equality = true,
      },
      nav = {
        win_opts = { winblend = 0 },
        keymaps = {
          ["q"] = "actions.close",
        },
      },
      show_guides = true,
      filter_kind = false,
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
      require("lspconfig.ui.windows").default_options = {
        border = "rounded",
      }
      require("lazyvim.util").on_attach(require("custom.lsp").on_attach)

      opts.diagnostics.virtual_text = { spacing = 4, prefix = "●", source = true }
      opts.diagnostics.float = { border = "rounded" }
      opts.autoformat = false
      opts.format = {
        formatting_options = nil,
        timeout_ms = 5000,
      }
      opts.inlay_hints = {
        enabled = true,
      }
      opts.servers.hls = {
        cmd = { "haskell-language-server-wrapper", "--lsp" },
        filetypes = { "haskell", "lhaskell", "cabal" },
        settings = {
          haskell = {
            cabalFormattingProvider = "cabalfmt",
            formattingProvider = "ormolu",
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
    "williamboman/mason.nvim",
    opts = {
      ui = { border = "rounded", width = 0.8, height = 0.8 },
    },
  },
}
