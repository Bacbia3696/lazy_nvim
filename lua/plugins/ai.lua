return {
  -- { "augmentcode/augment.vim" },
  {
    "ravitemer/mcphub.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    config = function()
      require("mcphub").setup({
        -- Required options
        port = 3000, -- Port for MCP Hub server
        config = vim.fn.expand("~/mcpservers.json"), -- Absolute path to config file

        -- Optional options
        on_ready = function(hub)
          -- Called when hub is ready
        end,
        on_error = function(err)
          -- Called on errors
        end,
        log = {
          level = vim.log.levels.WARN,
          to_file = false,
          file_path = nil,
          prefix = "MCPHub",
        },
      })
    end,
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    lazy = true,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "openrouter",
      providers = {
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "cmd:bw get notes openrouter-api",
          model = "deepseek/deepseek-chat:free",
        },
        perplexity = {
          __inherited_from = "openai",
          api_key_name = "cmd:bw get notes pplx-api",
          endpoint = "https://api.perplexity.ai",
          model = "llama-3.1-sonar-large-128k-online",
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              enabled = false,
              insert_mode = false,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
