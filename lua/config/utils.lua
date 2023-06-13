local M = {}
function M.on_attach(client, bufnr)
  local keys = require("lazyvim.plugins.lsp.keymaps").get()
  keys[#keys + 1] = { "ga", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
  keys[#keys + 1] = { "go", vim.diagnostic.open_float, desc = "Line Diagnostics" }
  keys[#keys + 1] = { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" }
  keys[#keys + 1] = { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" }
  keys[#keys + 1] = { "gL", vim.lsp.codelens.refresh, desc = "LSP CodeLens refresh" }
  keys[#keys + 1] = { "gl", vim.lsp.codelens.run, desc = "LSP CodeLens run" }
  keys[#keys + 1] = {
    "[D",
    function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end,
    desc = "diagnostic goto prev ERROR",
  }
  keys[#keys + 1] = {
    "]D",
    function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end,
    desc = "diagnostic goto prev ERROR",
  }
  keys[#keys + 1] = { "cc", "<cmd>LspRestart<cr>", desc = "Lsp restart" }
  keys[#keys + 1] = {
    "gI",
    function()
      require("lsp-inlayhints").toggle()
    end,
    desc = "Lsp inlay toggle",
  }

  -- add codelens for on_attach function
  local capabilities = client.server_capabilities
  if capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter", "CursorHold" }, {
      group = Augroup("lsp_codelens_refresh"),
      callback = vim.lsp.codelens.refresh,
      buffer = 0,
    })
  end
  if client.name == "gopls" or client.name == "rust_analyzer" or client.name == "tsserver" then
    require("lsp-inlayhints").on_attach(client, bufnr, true)
  end
end

return M
