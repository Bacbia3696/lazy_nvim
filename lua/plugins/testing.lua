return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-plenary",
    },
    opts = function(_, opts)
      opts.adapters = {
        require("neotest-go")({
          experimental = { test_table = true },
          args = { "-count=1", "-timeout=60s" },
        }),
        require("neotest-plenary"),
        require("neotest-rust"),
      }
      opts.icons = { running_animated = { "◐", "◓", "◑", "◒" } }
    end,
  },
  { "andythigpen/nvim-coverage", lazy = false, opts = { auto_reload = true } },
}
