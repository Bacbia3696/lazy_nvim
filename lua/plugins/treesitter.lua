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

  vim.cmd("normal! \27") -- Exit visual mode
  vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
  vim.cmd("normal! v")

  -- Handle treesitter's exclusive end_col
  if end_col == 0 then
    vim.fn.setpos(".", { 0, end_row, 2147483647, 0 }) -- End of previous line
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
    keys = {
      { "<CR>", M.increment, mode = { "n", "x" }, desc = "Incremental selection" },
      { "<BS>", M.decrement, mode = "x", desc = "Shrink selection" },
    },
  },
}
