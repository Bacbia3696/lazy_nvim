return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display = { shorten = 7, exclude = { 1, -1 } },
        prompt_prefix = "🔭 ",
        selection_caret = " ",
        vimgrep_arguments = { "rg", "--vimgrep", "--smart-case", "-M", "200" },
      },
      pickers = {
        lsp_references = { include_declaration = false, show_line = false },
        lsp_implementations = { show_line = false },
        -- live_grep = { glob_pattern = { "!api/*", "!go.sum" } },
      },
      extensions = {
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
      },
    },
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
