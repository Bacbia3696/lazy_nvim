return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      preview = {
        vertical = "down:65%",
        layout = "vertical",
        scrollchars = { "┃", "" },
      },
    },
    ui_select = function(fzf_opts, items)
      return vim.tbl_deep_extend("force", fzf_opts, {
        prompt = " ",
        winopts = {
          title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
          title_pos = "center",
        },
      }, fzf_opts.kind == "codeaction" and {
        winopts = {
          layout = "vertical",
          height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 5) + 0.5) + 16,
          width = 0.5,
          preview = not vim.tbl_isempty(LazyVim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
            layout = "vertical",
            vertical = "down:15,border-top",
            hidden = "hidden",
          } or {
            layout = "vertical",
            vertical = "down:15,border-top",
          },
        },
      } or {
        winopts = {
          width = 0.5,
          -- height is number of items, with a max of 80% screen height
          height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
        },
      })
    end,
  },
}
