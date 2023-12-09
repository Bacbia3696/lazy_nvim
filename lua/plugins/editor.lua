return {
  {
    "folke/flash.nvim",
    keys = function(_, keys)
      for _, value in ipairs(keys) do
        if value[1] == "S" then
          value[1] = "<localleader>s"
        end
      end
    end,
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        HACK = { icon = " ", color = "warning", alt = { "SAFETY", "Safety" } },
      },
    },
  },
  {
    "johmsalas/text-case.nvim",
    config = function(_, opts)
      require("textcase").setup(opts)
      require("telescope").load_extension("textcase")
      vim.api.nvim_set_keymap("", "<leader>ga", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Change text case" })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      open_files_do_not_replace_types = { "terminal", "trouble", "qf", "aerial" }, -- when opening files, do not use windows containing these filetypes or buftypes
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
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
          ["o"] = "open_check_images",
          ["/"] = false,
          ["?"] = false,
          ["g?"] = "show_help",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
        },
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
            vim.api.nvim_input(": " .. state.tree:get_node().path .. "<Home>")
          end,
          copy_filename = function(state)
            require("helpers").copy(state.tree:get_node().path)
          end,
          open_check_images = function(state)
            local node = state.tree:get_node()
            if vim.list_contains({ "jpg", "png", "jpeg" }, node.ext) then
              require("helpers").open(node.path)
            else
              vim.cmd("edit " .. node.path)
            end
          end,
        },
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
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
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "http",
    lazy = true,
    opts = {
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Keep the HTTP file buffer above|left when split horizontal|vertical
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
  {
    "folke/which-key.nvim",
    opts = {
      window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        zindex = 1000, -- positive value to position WhichKey above other floating windows.
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.current_line_blame = true
    end,
  },
  -- color picker
  {
    "uga-rosa/ccc.nvim",
    enabled = false,
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
  },
}
