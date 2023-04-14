-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

require("lazyvim.util").on_attach(function(client, _)
  local capabilities = client.server_capabilities
  if capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter" }, {
      group = augroup("lsp_codelens_refresh"),
      callback = function()
        if vim.g.codelens_enabled then
          vim.lsp.codelens.refresh()
        end
      end,
    })
    -- NOTE: this is quite hacky, because we can call codelens in the begining
    vim.fn.timer_start(100, vim.lsp.codelens.refresh, { ["repeat"] = 5 })
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "gL", vim.lsp.codelens.refresh, desc = "LSP CodeLens refresh", mode = { "n" } }
    keys[#keys + 1] = { "gl", vim.lsp.codelens.run, desc = "LSP CodeLens run", mode = { "n" } }
  end
end)
