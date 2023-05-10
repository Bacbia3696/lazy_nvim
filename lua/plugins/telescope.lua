return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults.path_display = { shorten = 7, exclude = { 1, -1 } }
      opts.defaults.prompt_prefix = "🔭 "
      opts.defaults.selection_caret = " "
      opts.defaults.vimgrep_arguments = { "rg", "--vimgrep", "--smart-case", "-M", "200" }

      opts.pickers = {
        lsp_references = { include_declaration = false, show_line = false },
        lsp_implementations = { show_line = false },
        -- live_grep = { glob_pattern = { "!api/*", "!go.sum" } },
      }
      opts.extensions = {
        emoji = {
          action = function(emoji)
            -- argument emoji is a table.
            -- {name="", value="", cagegory="", description=""}

            -- vim.fn.setreg("*", emoji.value)
            -- print([[Press p or "*p to paste this emoji]] .. emoji.value)

            -- insert emoji when picked
            vim.api.nvim_put({ emoji.value }, "b", false, true)
          end,
        },
      }
    end,
  },
  {
    "xiyaowong/telescope-emoji.nvim",
    keys = {
      { "<leader>se", "<cmd>Telescope emoji<cr>", desc = "Telescope search emoji" },
    },
    config = function()
      require("telescope").load_extension("emoji")
    end,
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
              -- default = mapping.put("p"),
              i = {
                ["<c-p>"] = require("telescope.actions").move_selection_previous,
                ["<cr>"] = mapping.put("p"),
                ["<S-CR>"] = mapping.put("P"),
                ["<c-x>"] = mapping.delete(),
                ["<c-r>"] = mapping.set_register(utils.get_default_register()),
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
}
