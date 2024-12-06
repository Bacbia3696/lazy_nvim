return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      styles = {
        terminal = {
          border = vim.g.border,
        },
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    opts = {
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%[%.%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = {},
      mappings = {
        -- exclude b'', and <' for Rust
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^ac-z\\&<].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-cmdline", { "jackieaskins/cmp-emmet", build = "npm run release" } },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "emmet" },
      }))
      opts.mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
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
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },
}
