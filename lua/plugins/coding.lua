return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji", { "roobert/tailwindcss-colorizer-cmp.nvim", config = true } },
    opts = function(_, opts)
      local cmp = require("cmp")
      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }
      opts.window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
      }
      opts.preselect = cmp.PreselectMode.None
      opts.sources = vim.list_extend(opts.sources, { { name = "emoji" } })
      -- original LazyVim kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
      local option = { behavior = cmp.SelectBehavior.Insert }
      opts.mapping = {
        ["<C-n>"] = function(fallback)
          if cmp.visible() then
            if not cmp.select_next_item(option) then
              local release = require("cmp").core:suspend()
              fallback()
              vim.schedule(release)
            end
          else
            if not require("cmp").complete() then
              fallback()
            end
          end
        end,
        ["<C-p>"] = function(fallback)
          if cmp.visible() then
            if not cmp.select_prev_item(option) then
              local release = require("cmp").core:suspend()
              fallback()
              vim.schedule(release)
            end
          else
            if not require("cmp").complete() then
              fallback()
            end
          end
        end,
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          select = false,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}
