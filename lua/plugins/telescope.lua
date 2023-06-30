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
}
