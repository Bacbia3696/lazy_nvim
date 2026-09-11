-- Incremental selection using treesitter
local M = { nodes = {} }

-- Helper: check if two nodes have the same range
local function same_range(node1, node2)
  local s1, c1, e1, ec1 = node1:range()
  local s2, c2, e2, ec2 = node2:range()
  return s1 == s2 and c1 == c2 and e1 == e2 and ec1 == ec2
end

-- Helper: visually select a node's range
local function select_node(node)
  local start_row, start_col, end_row, end_col = node:range()

  vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true)) -- Exit visual mode
  vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
  vim.cmd("normal! v")

  -- Handle treesitter's exclusive end_col
  if end_col == 0 then
    vim.fn.setpos(".", { 0, end_row, vim.v.maxcol, 0 }) -- End of previous line
  else
    vim.fn.setpos(".", { 0, end_row + 1, end_col, 0 })
  end
end

function M.init()
  local node = vim.treesitter.get_node()
  if not node then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  M.nodes[bufnr] = { node }
  select_node(node)
end

function M.increment()
  local bufnr = vim.api.nvim_get_current_buf()
  local nodes = M.nodes[bufnr]
  local is_visual = vim.fn.mode():match("[vV\22]")

  -- Start fresh if no history or not in visual mode
  if not nodes or #nodes == 0 or not is_visual then
    return M.init()
  end

  -- Find parent with different range
  local current = nodes[#nodes]
  local parent = current:parent()

  while parent and same_range(current, parent) do
    parent = parent:parent()
  end

  if not parent then
    return
  end

  table.insert(nodes, parent)
  select_node(parent)
end

function M.decrement()
  local bufnr = vim.api.nvim_get_current_buf()
  local nodes = M.nodes[bufnr]

  if not nodes or #nodes <= 1 then
    return
  end

  table.remove(nodes)
  select_node(nodes[#nodes])
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "http" })
    end,
    init = function()
      -- drop selection history when a buffer goes away
      vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
        group = vim.api.nvim_create_augroup("custom_ts_selection", { clear = true }),
        callback = function(ev)
          M.nodes[ev.buf] = nil
        end,
      })
    end,
    keys = {
      {
        "<CR>",
        function()
          -- keep builtin <CR> in special buffers (quickfix, help, terminal, ...)
          if vim.bo.buftype ~= "" then
            return "<CR>"
          end
          -- no parser for this buffer: keep the default <CR> behavior
          if not vim.treesitter.get_node() then
            return "<CR>"
          end
          M.increment()
        end,
        mode = { "n", "x" },
        expr = true,
        desc = "Incremental selection",
      },
      { "<BS>", M.decrement, mode = "x", desc = "Shrink selection" },
      -- markdown code block textobjects (after/queries/markdown/textobjects.scm)
      -- requires nvim-treesitter-textobjects (LazyVim treesitter extra)
      {
        "im",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@code_block.inner", "textobjects")
        end,
        mode = { "x", "o" },
        ft = "markdown",
        desc = "inner code block",
      },
      {
        "am",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@code_block.outer", "textobjects")
        end,
        mode = { "x", "o" },
        ft = "markdown",
        desc = "around code block",
      },
    },
  },
}
