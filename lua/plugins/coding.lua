return {
  {
    "echasnovski/mini.surround",
    enabled = false,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
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
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\&<].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { { "hrsh7th/cmp-cmdline" }, { "onsails/lspkind.nvim" } },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.cmdline = {
        [":"] = {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            {
              name = "cmdline",
              option = {
                ignore_cmds = { "Man", "!" },
              },
            },
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
      opts.formatting = {
        format = function(_, item)
          item.menu = nil
          item.kind = (require("lazyvim.config").icons.kinds[item.kind] or "") .. item.kind
          return item
        end,
      }
      opts.preselect = cmp.PreselectMode.None
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      })
      opts.mapping = {
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c", "s" }),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c", "s" }),
        -- ["<C-n>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     cmp.select_next_item()
        --   elseif not cmp.complete() then
        --     fallback()
        --   end
        -- end, { "i", "s", "c" }),
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
