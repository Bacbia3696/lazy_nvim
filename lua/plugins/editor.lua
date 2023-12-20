return {
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
        mappings = {
          ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["o"] = {
            function(state)
              local node = state.tree:get_node()
              if vim.list_contains({ "jpg", "png", "jpeg" }, node.ext) then
                vim.ui.open(node.path)
              else
                vim.cmd.edit(node.path)
              end
            end,
            nowait = true,
          },
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
        },
        window = {
          mappings = {
            ["i"] = {
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
