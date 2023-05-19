return {
  {
    "folke/zen-mode.nvim",
    events = "ZenMode",
    opts = {
      window = {
        height = 0.8,
        options = {
          fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
        },
      },
      on_open = function()
        vim.cmd("hi ZenBg guibg=None")
      end,
    },
  },
  {
    "aserowy/tmux.nvim",
    lazy = true,
    keys = {
      "<M-h>",
      "<M-j>",
      "<M-k>",
      "<M-l>",
      "<C-h>",
      "<C-j>",
      "<C-k>",
      "<C-l>",
    },
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
    "nyngwang/NeoZoom.lua",
    keys = {
      { "<S-F>", "<cmd>NeoZoomToggle<cr>", desc = "Toggle NeoZoom" },
    },
    opts = {
      popup = {
        enabled = true,
        exclude_buftypes = { "terminal" },
        exclude_filetypes = { "lspinfo", "mason", "lazy", "fzf", "qf" },
      },
      winopts = {
        offset = {
          width = 110,
          height = 0.9,
        },
        border = "rounded",
      },
      presets = {
        {
          filetypes = { "dapui_.*", "dap-repl" },
          winopts = {
            offset = { top = 0, left = 0.6, width = 0.4, height = 0.7 },
          },
        },
        {
          filetypes = { "markdown" },
          callbacks = {
            function()
              vim.wo.wrap = true
            end,
          },
        },
      },
    },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
}
