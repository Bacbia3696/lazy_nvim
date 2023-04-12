return {
  {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-plenary",
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        -- your neotest config here
        adapters = {
          require("neotest-go")({
            experimental = { test_table = true },
            args = { "-count=1", "-timeout=60s" },
          }),
          require("neotest-plenary"),
          require("neotest-rust"),
        },
        icons = { running_animated = { "◐", "◓", "◑", "◒" } },
      })
    end,
  },
  { "andythigpen/nvim-coverage", lazy = false, opts = { auto_reload = true } },
}
