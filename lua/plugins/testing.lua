return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-plenary",
    },
    opts = function(_, opts)
      opts.adapters = {
        require("neotest-plenary"),
      }
      opts.icons = { running_animated = { "◐", "◓", "◑", "◒" } }
    end,
  },
  { "andythigpen/nvim-coverage", lazy = false, opts = { auto_reload = true } },
}
