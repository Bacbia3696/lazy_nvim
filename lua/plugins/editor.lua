return {
  { "ggandor/flit.nvim", enabled = false },
  { "ggandor/leap.nvim", enabled = false },
  {
    "aserowy/tmux.nvim",
    opts = {},
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

          map("n", "<leader>ct", crates.toggle, "crates toggle")
          map("n", "<leader>cr", crates.reload, "crates reload")
          map("n", "<leader>cv", crates.show_versions_popup, "crates show version popup")
          map("n", "<leader>cf", crates.show_features_popup, "crates show features popup")
          map("n", "<leader>cd", crates.show_dependencies_popup, "crates show dependencies popup")
          map("n", "<leader>cu", crates.update_crate, "crates update")
          map("v", "<leader>cu", crates.update_crates, "crates update")
          map("n", "<leader>ca", crates.update_all_crates, "crates update all")
          map("n", "<leader>cU", crates.upgrade_crate, "crates upgrade")
          map("v", "<leader>cU", crates.upgrade_crates, "crates upgrade")
          map("n", "<leader>cA", crates.upgrade_all_crates, "crates upgrade all")
          map("n", "<leader>cH", crates.open_homepage, "crates open homepage")
          map("n", "<leader>cR", crates.open_repository, "crates open repository")
          map("n", "<leader>cD", crates.open_documentation, "crates open documentation")
          map("n", "<leader>cC", crates.open_crates_io, "crates open crates.io")
        end,
      })
    end,
    config = function()
      require("crates").setup()
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" }, ignored_buftypes = { "nofile" } },
  },
  {
    "szw/vim-maximizer",
    keys = "<M-m>",
    init = function()
      vim.g.maximizer_default_mapping_key = "<M-m>"
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup({
        selection_chars = "QWEASDZXC",
        fg_color = "#FFABCB",
        include_current_win = true,
        other_win_hl_color = "#41644A",
        filter_rules = {
          bo = {
            filetype = {},
            buftype = {},
          },
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      { "mrbjarksen/neo-tree-diagnostics.nvim" },
    },
    opts = {
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "diagnostics",
        "document_symbols",
      },
      diagnostics = {
        auto_preview = { -- May also be set to `true`
          enabled = true, -- Whether to automatically enable preview mode
          preview_config = {}, -- Config table to pass to auto preview (for example `{ use_float = true }`)
          event = "neo_tree_buffer_enter", -- The event to enable auto preview upon (for example `"neo_tree_window_after_open"`)
        },
        bind_to_cwd = true,
        diag_sort_function = "severity", -- "severity" means diagnostic items are sorted by severity in addition to their positions.
        -- "position" means diagnostic items are sorted strictly by their positions.
        -- May also be a function.
        follow_behavior = { -- Behavior when `follow_current_file` is true
          always_focus_file = false, -- Focus the followed file, even when focus is currently on a diagnostic item belonging to that file.
          expand_followed = true, -- Ensure the node of the followed file is expanded
          collapse_others = true, -- Ensure other nodes are collapsed
        },
        follow_current_file = true,
        group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
        group_empty_dirs = true, -- when true, empty directories will be grouped together
        show_unloaded = true, -- show diagnostics from unloaded buffers
        refresh = {
          delay = 100, -- Time (in ms) to wait before updating diagnostics. Might resolve some issues with Neovim hanging.
          event = "vim_diagnostic_changed", -- Event to use for updating diagnostics (for example `"neo_tree_buffer_enter"`)
          -- Set to `false` or `"none"` to disable automatic refreshing
          max_items = false, -- The maximum number of diagnostic items to attempt processing
          -- Set to `false` for no maximum
        },
      },
      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function(args)
            if args.position == "left" or args.position == "right" then
              vim.cmd("wincmd =")
            end
          end,
        },
        {
          event = "neo_tree_window_after_close",
          handler = function(args)
            if args.position == "left" or args.position == "right" then
              vim.cmd("wincmd =")
            end
          end,
        },
      },
      use_libuv_file_watcher = true,
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
          ["o"] = "open",
          ["/"] = false,
          ["?"] = false,
          ["g?"] = "show_help",
        },
      },
      filesystem = {
        window = {
          mappings = {
            ["i"] = "run_command",
            ["<space>"] = "none",
            ["Y"] = "copy_filename",
            ["F"] = "fuzzy_finder",
          },
        },
        commands = {
          run_command = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.api.nvim_input(": " .. path .. "<Home>")
          end,
          copy_filename = function(state)
            local file_name = state.tree:get_node().name
            vim.cmd("!echo " .. file_name .. " | pbcopy")
          end,
        },
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    config = function()
      local utils = require("yanky.utils")
      local mapping = require("yanky.telescope.mapping")
      require("yanky").setup({
        highlight = {
          timer = 250,
        },
        picker = {
          telescope = {
            mappings = {
              default = mapping.put("p"),
              i = {
                ["<cr>"] = mapping.put("p"),
                ["<S-CR>"] = mapping.put("P"),
                ["<c-x>"] = mapping.delete(),
                ["<c-r>"] = mapping.set_register(utils.get_default_register()),
                -- ["<c-k>"] = require("telescope.actions").move_selection_previous,
              },
              n = {
                p = mapping.put("p"),
                P = mapping.put("P"),
                d = mapping.delete(),
                r = mapping.set_register(utils.get_default_register()),
              },
            },
          },
        },
      })
      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

      require("telescope").load_extension("yank_history")
      vim.keymap.set("n", "<leader>sy", require("telescope").extensions.yank_history.yank_history)
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    opts = {
      scratchPad = {
        -- set to `false` to
        -- disable auto-saving
        enabled = true,
        -- set to `nil` to default
        -- to current working directory
        location = "~/Documents/",
      },
      bo = {
        filetype = "md",
      },
      buffers = {
        colors = {
          blend = -0.4,
        },
      },
    },
  },
  -- {
  --   "folke/zen-mode.nvim",
  --   events = "ZenMode",
  -- },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      { "kevinhwang91/promise-async" },
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<C-\\>" },
    },
    opts = {
      size = 10,
      open_mapping = [[<c-\>]],
      shading_factor = 2,
      autochdir = true,
      highlights = {
        FloatBorder = {
          link = "FloatBorder",
        },
      },
      direction = "float",
      float_opts = {
        border = "rounded",
        highlights = { border = "Normal", background = "Normal" },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults.path_display = { shorten = 7, exclude = { 1, -1 } }
      opts.defaults.prompt_prefix = "🔭 "
      opts.defaults.selection_caret = " "
      opts.defaults.mappings.i["<C-j>"] = require("telescope.actions").move_selection_next
      opts.defaults.mappings.i["<C-k>"] = require("telescope.actions").move_selection_previous
      opts.defaults.vimgrep_arguments = { "rg", "--vimgrep", "--smart-case", "-M", "200" }

      opts.pickers = {
        lsp_references = { include_declaration = false, show_line = false },
        lsp_implementations = { show_line = false },
        -- live_grep = { glob_pattern = { "!api/*", "!go.sum" } },
      }
    end,
  },
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    opts = {
      mapping = {
        ["run_current_replace"] = {
          map = "r",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line",
        },
      },
    },
  },
  {
    "rest-nvim/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    ft = "http",
    lazy = true,
    opts = {
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Encode URL before making request
      encode_url = true,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
      },
      -- Jump to request line on run
      jump_to_request = true,
      env_file = ".env",
      custom_dynamic_variables = {},
      yank_dry_run = true,
    },
  },
}
