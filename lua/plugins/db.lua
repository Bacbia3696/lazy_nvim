return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    opts = {
      -- lazy load the plugin or not?
      lazy = false,

      -- list of connections
      -- don't commit that, use something like nvim-projector for project specific config.
      connections = {
        -- example:
        {
          name = "postgres",
          type = "postgres",
          url = "postgres://postgres:password@localhost:5432/db?sslmode=disable",
        },
      },
      -- extra table helpers per connection type
      extra_helpers = {
        ["postgres"] = {
          ["List All"] = "select * from {table}",
        },
      },
    },
    config = function()
      require("dbee").setup( --[[optional config]])
    end,
  },
}
