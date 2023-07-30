return {
  {
    "echasnovski/mini.surround",
    enabled = false,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.pairs",
    opts = {
      mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
        -- exclude b'', and <' for Rust
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^ac-z\\&<].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-cmdline" },
    opts = function(_, opts)
      opts.formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(_, item)
          -- Define menu shorthand for different completion sources.
          ---@diagnostic disable-next-line: unused-local
          local menu_icon = {
            nvim_lsp = "",
            nvim_lua = "",
            luasnip = "",
            buffer = "",
            path = "",
          }
          item.menu = ""
          -- item.menu = ""
          -- local fixed_width = 20
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
      }

      local cmp = require("cmp")
      opts.cmdline = {
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
      }

      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:None,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }
      opts.window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
      }
      opts.preselect = cmp.PreselectMode.None
      -- local sources = cmp.config.sources({
      --   { name = "nvim_lsp", priority = 1000 },
      --   { name = "luasnip",  priority = 750 },
      --   { name = "buffer",   priority = 500 },
      --   { name = "path",     priority = 250 },
      -- })
      opts.mapping = {
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c", "s" }),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c", "s" }),
        ["<C-g>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-y>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          select = false,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }
    end,
  },
}
