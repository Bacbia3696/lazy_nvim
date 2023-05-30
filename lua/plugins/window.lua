return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        height = 0.8,
        width = 100,
        options = {
          fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
          signcolumn = "number",
        },
      },
      on_open = function()
        vim.cmd("hi ZenBg guibg=None")
        -- vim.o.signcolumn = "number"
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
    opts = {},
  },
  {
    "s1n7ax/nvim-window-picker",
    opts = {
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
    },
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
          height = 0.8,
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
