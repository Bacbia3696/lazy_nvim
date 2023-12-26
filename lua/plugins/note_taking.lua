return {
  {
    "nvim-neorg/neorg",
    event = "VeryLazy",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behavior
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
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },
    },
  },
}
