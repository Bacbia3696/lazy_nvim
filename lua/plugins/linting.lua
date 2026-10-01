local state_file = vim.fn.stdpath("state") .. "/disabled-linters.json"

local function current_root()
  local cwd = vim.fn.getcwd()
  return vim.uv.fs_realpath(cwd) or cwd
end

local function in_root(filename, root)
  local file = vim.uv.fs_realpath(filename) or filename
  local prefix = root:sub(-1) == "/" and root or root .. "/"
  return file == root or vim.startswith(file, prefix)
end

local ok, disabled_linters = pcall(function()
  return vim.json.decode(table.concat(vim.fn.readfile(state_file), "\n"))
end)
disabled_linters = ok and type(disabled_linters) == "table" and disabled_linters or {}

local function save_disabled()
  vim.fn.mkdir(vim.fs.dirname(state_file), "p")
  local temp_file = state_file .. "." .. vim.uv.hrtime() .. ".tmp"
  vim.fn.writefile({ vim.json.encode(next(disabled_linters) and disabled_linters or vim.empty_dict()) }, temp_file)
  local ok, err = vim.uv.fs_rename(temp_file, state_file)
  if not ok then
    vim.uv.fs_unlink(temp_file)
    error(err)
  end
end

local function get_linters()
  require("lazy").load({ plugins = { "nvim-lint" } })
  local lint = require("lint")
  local names = lint._resolve_linter_by_ft(vim.bo.filetype)
  if #names == 0 then
    names = lint.linters_by_ft["_"] or {}
  end
  return vim.list_extend(vim.list_extend({}, names), lint.linters_by_ft["*"] or {})
end

local function toggle_linter(name)
  local root = current_root()
  local project = disabled_linters[root] or {}
  local disabling = not project[name]
  project[name] = disabling or nil
  disabled_linters[root] = next(project) and project or nil
  save_disabled()

  local lint = require("lint")
  if disabling then
    local namespace = lint.get_namespace(name)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if in_root(vim.api.nvim_buf_get_name(buf), root) then
        vim.diagnostic.reset(namespace, buf)
      end
    end
  elseif in_root(vim.api.nvim_buf_get_name(0), root) then
    lint.try_lint(name)
  end
  vim.notify(("%s %s for %s"):format(name, disabling and "disabled" or "enabled", root))
end

local function resolve_linters(name)
  local names = get_linters()
  if name ~= "" then
    if not vim.tbl_contains(names, name) then
      return vim.notify(name .. " is not configured for this buffer", vim.log.levels.WARN)
    end
    return { name }
  end
  if #names == 0 then
    return vim.notify("No linters configured for this buffer", vim.log.levels.WARN)
  end
  return names
end

local function select_linter(name)
  local names = resolve_linters(name)
  if not names then
    return
  end
  if #names == 1 then
    return toggle_linter(names[1])
  end
  vim.ui.select(names, { prompt = "Toggle linter" }, function(choice)
    if choice then
      toggle_linter(choice)
    end
  end)
end

local function show_status(name)
  local names = resolve_linters(name)
  if not names then
    return
  end

  local root = current_root()
  local project = disabled_linters[root] or {}
  local status = vim.tbl_map(function(linter)
    return linter .. ": " .. (project[linter] and "disabled" or "enabled")
  end, names)
  vim.notify(table.concat(status, "\n"), nil, { title = "Linters · " .. root })
end

local function project_condition(name, condition)
  return function(ctx)
    local root = current_root()
    if not in_root(ctx.filename, root) or (disabled_linters[root] or {})[name] then
      return false
    end
    return not condition or condition(ctx)
  end
end

return {
  {
    "mfussenegger/nvim-lint",
    init = function()
      vim.api.nvim_create_user_command("LintToggle", function(cmd)
        select_linter(cmd.args)
      end, {
        nargs = "?",
        complete = function()
          return get_linters()
        end,
        desc = "Toggle a linter for the current project",
        force = true,
      })
      vim.api.nvim_create_user_command("LintStatus", function(cmd)
        show_status(cmd.args)
      end, {
        nargs = "?",
        complete = function()
          return get_linters()
        end,
        desc = "Show linter status for the current project",
        force = true,
      })
    end,
    keys = {
      { "<leader>ue", "<cmd>LintToggle<cr>", desc = "Toggle Linter (Project)" },
    },
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.go = { "revive" }
      opts.linters = opts.linters or {}

      local configured = {}
      for _, names in pairs(opts.linters_by_ft) do
        for _, name in ipairs(names) do
          configured[name] = true
        end
      end
      for name in pairs(configured) do
        if type(opts.linters[name]) ~= "function" then
          local linter = opts.linters[name] or {}
          linter.condition = project_condition(name, linter.condition)
          opts.linters[name] = linter
        end
      end
    end,
  },
}
