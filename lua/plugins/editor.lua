return {
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
    tag = "v1.*",
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
}
