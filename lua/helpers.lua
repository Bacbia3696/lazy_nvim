local M = {}

--- Util to create mapping
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table|nil
function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

--- Util to create augroup
---@param name string:
---@return number
function M.augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

--- Copy `text` to system clipboard
---@param text string
function M.copy(text)
  vim.fn.setreg("+", text)
  vim.notify("Copied " .. text .. " to Clipboard")
end

--- Open `file` with OS default application
---@param file string
function M.open(file)
  local command = vim.fn.has("mac") == 1 and "open" or "xdg-open"
  vim.fn.jobstart(command .. " " .. file)
end

--- Custom on attach function when load lsp
function M.on_attach(client, _)
  local keys = require("lazyvim.plugins.lsp.keymaps").get()

  keys[#keys + 1] = { "<leader>cS", "<cmd>LspStop<cr>", desc = "Lsp Stop" }
  keys[#keys + 1] = { "<leader>cR", "<cmd>LspRestart<cr>", desc = "Lsp Stop" }
  keys[#keys + 1] = { "go", vim.diagnostic.open_float, desc = "Open diagnostics on float window" }
  keys[#keys + 1] = { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" }
  keys[#keys + 1] = { "gL", vim.lsp.codelens.refresh, desc = "LSP CodeLens refresh" }
  keys[#keys + 1] = { "gl", vim.lsp.codelens.run, desc = "LSP CodeLens run" }
  -- stylua: ignore
  keys[#keys + 1] = { "[D", function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, desc = "diagnostic goto prev ERROR",
  }
  -- stylua: ignore
  keys[#keys + 1] = { "]D", function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, desc = "diagnostic goto next ERROR",
  }
  keys[#keys + 1] = { "<leader>cR", "<cmd>LspRestart<cr>", desc = "Lsp restart" }

  -- add codelens for on_attach function
  local capabilities = client.server_capabilities
  if capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter" }, {
      group = M.augroup("lsp_codelens_refresh"),
      callback = vim.lsp.codelens.refresh,
      buffer = 0,
    })
  end
end

return M
