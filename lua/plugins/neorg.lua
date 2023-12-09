return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        }, -- Enables support for completion plugins
        ["core.summary"] = {}, -- Enables support for the summary module
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            default_workspace = "default",
            workspaces = {
              default = "~/neorg",
            },
          },
        },
        ["core.ui.calendar"] = {},
      },
    },
  },
}
