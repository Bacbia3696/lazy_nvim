return {
  {
    "stevearc/aerial.nvim",
    opts = function()
      return {
        backends = { "treesitter", "lsp", "markdown", "man" },
        layout = {
          max_width = { 40, 0.2 },
          width = nil,
          min_width = 20,
        },
      }
    end,
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = { search = { enabled = false } },
    },
    keys = function()
      return {}
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
      window = {
        width = 30,
      },
      -- Equalize Window Sizes on Neo-tree Open and Close
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
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
        },
        window = {
          mappings = {
            ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
            ["Oc"] = { "order_by_created", nowait = false },
            ["Od"] = { "order_by_diagnostics", nowait = false },
            ["Og"] = { "order_by_git_status", nowait = false },
            ["Om"] = { "order_by_modified", nowait = false },
            ["On"] = { "order_by_name", nowait = false },
            ["Os"] = { "order_by_size", nowait = false },
            ["Ot"] = { "order_by_type", nowait = false },
            ["o"] = {
              function(state)
                local node = state.tree:get_node()
                if not vim.list_contains({ "jpg", "png", "jpeg" }, node.ext) then
                  state.commands.open(state)
                else
                  vim.ui.open(node.path)
                end
              end,
              nowait = true,
            },
            ["!"] = {
              function(state)
                vim.api.nvim_input(": " .. state.tree:get_node().path .. "<Home>")
              end,
              nowait = true,
            },
            ["Y"] = {
              function(state)
                require("helpers").copy(state.tree:get_node().path)
              end,
              nowait = true,
            },
          },
        },
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {
      highlight = {
        ui = "@keyword",
        search = "NeogitDiffDeleteHighlight",
        replace = "NeogitDiffAddHighlight",
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
    opts = {
      highlighter = {
        auto_enable = false,
        lsp = false,
      },
    },
  },
}
