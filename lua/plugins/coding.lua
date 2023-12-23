return {
  {
    "echasnovski/mini.pairs",
    opts = {
      mappings = {
        -- exclude b'', and <' for Rust
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^ac-z\\&<].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-cmdline" },
    keys = {
      {
        "<leader>tc",
        function()
          -- if vim.fn.exists("b:cmp") == 0 or vim.api.nvim_buf_get_var(0, "cmp") then
          --   vim.api.nvim_buf_set_var(0, "cmp", false)
          --   require("cmp").setup.buffer({ enabled = false })
          --   require("lazyvim.util").info("Disable", { title = "Toggle auto completion" })
          -- else
          --   vim.api.nvim_buf_set_var(0, "cmp", true)
          --   require("cmp").setup.buffer({ enabled = true })
          --   require("lazyvim.util").info("Enable", { title = "Toggle auto completion" })
          -- end
          local cmp = require("cmp")
          local current_setting = cmp.get_config().completion.autocomplete
          if current_setting and #current_setting > 0 then
            cmp.setup({ completion = { autocomplete = false } })
            require("lazyvim.util").info("Disable", { title = "Toggle auto completion" })
          else
            cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } })
            require("lazyvim.util").info("Enable", { title = "Toggle auto completion" })
          end
        end,
        desc = "Toggle auto completion",
      },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-g>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }
      return vim.tbl_deep_extend("force", opts, {
        formatting = {
          format = function(_, item)
            -- set this help working with Rust show more concise completion window
            item.menu = ""
            local fixed_width = false
            local content = item.abbr
            if fixed_width then
              vim.o.pumwidth = fixed_width
            end
            local win_width = vim.api.nvim_win_get_width(0)
            local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.3)
            if #content > max_content_width then
              item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
            end

            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind]
            end
            return item
          end,
        },
        preselect = cmp.PreselectMode.None,
        cmdline = {
          [":"] = {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = "path" } }, {
              { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
            }),
          },
          ["/"] = {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = "buffer" },
            },
          },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
