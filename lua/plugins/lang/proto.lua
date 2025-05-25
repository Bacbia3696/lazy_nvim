return {
  {
    "stevearc/overseer.nvim",
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      overseer.register_template({
        name = "Codegen proto file",
        builder = function(params)
          return {
            cmd = "task",
            args = { "be:codegen", "--", vim.fn.expand("%:t") },
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          filetype = { "proto" },
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        proto = { "buf" },
      },
    },
  },
}
