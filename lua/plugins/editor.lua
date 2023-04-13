return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
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
    lazy = false,
    config = function()
      require("window-picker").setup({
        selection_chars = "QWEASDZXCRFVTGBYHNUJM",
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
          ["o"] = "open",
        },
      },
    },
  },
  { "ggandor/flit.nvim", enabled = false },
  { "ggandor/leap.nvim", enabled = false },
  {
    "folke/zen-mode.nvim",
    events = "ZenMode",
  },
  {
    "kevinhwang91/nvim-ufo",
    lazy = false,
    dependencies = "kevinhwang91/promise-async",
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      size = 10,
      open_mapping = [[<F7>]],
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults.path_display = { shorten = 5, exclude = { 1, -1 } }
      opts.defaults.prompt_prefix = "🔭 "
      opts.defaults.selection_caret = " "
      opts.defaults.mappings.i["<C-j>"] = require("telescope.actions").move_selection_next
      opts.defaults.mappings.i["<C-k>"] = require("telescope.actions").move_selection_previous

      opts.pickers = {
        lsp_references = { include_declaration = false, show_line = false },
        lsp_implementations = { show_line = false },
        live_grep = { glob_pattern = { "!api/*", "!go.sum" } },
      }
    end,
  },
}
