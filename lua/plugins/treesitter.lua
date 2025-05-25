return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        -- disable slow treesitter highlight for large files
        disable = function(_, buf)
          local max_filesize = 200 * 1024 -- 200 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { enable = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          scope_incremental = "<s-cr>",
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        lsp_interop = {
          enable = true,
          border = vim.g.border,
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>ck"] = "@function.outer",
            ["<leader>cK"] = "@class.outer",
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader><Right>"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader><Left>"] = "@parameter.inner",
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
  },
}
