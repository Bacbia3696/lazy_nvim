local leet_arg = "leetcode.nvim"

-- Auto-retry random problem if premium
local function random_with_retry(opts_str)
  return function()
    require("leetcode.utils").auth_guard()

    local max_retries = 10
    local attempt = 0

    local function try_random()
      attempt = attempt + 1

      local problems = require("leetcode.cache.problemlist")
      local question_api = require("leetcode.api.question")
      local log = require("leetcode.logger")

      -- Parse options from string like "difficulty=Easy status=todo"
      -- Must start with vim.empty_dict() to ensure it's always a JSON object, not array
      local opts = vim.empty_dict()

      if opts_str and opts_str ~= "" then
        for opt_pair in opts_str:gmatch("[^%s]+") do
          local key, value = opt_pair:match("(.+)=(.+)")
          if key and value then
            opts[key] = { value:lower() }
          end
        end
      end

      -- Transform options to match API format (matches cmd.random_question exactly)
      if opts and opts.difficulty then
        opts.difficulty = opts.difficulty[1]:upper()
      end
      if opts and opts.status then
        opts.status = ({
          ac = "AC",
          notac = "TRIED",
          todo = "NOT_STARTED",
        })[opts.status[1]]
      end

      local q, err = question_api.random(opts)

      if err then
        -- Check if it's a premium error
        if err.msg and err.msg:match("premium") then
          if attempt < max_retries then
            log.warn(("Premium problem (attempt %d/%d), retrying..."):format(attempt, max_retries))
            vim.defer_fn(try_random, 100) -- Small delay before retry
            return
          else
            log.error(("Hit premium problems %d times in a row. Try again later."):format(max_retries))
            return
          end
        else
          return log.err(err)
        end
      end

      if q then
        local item = problems.get_by_title_slug(q.title_slug) or {}
        local Question = require("leetcode-ui.question")
        Question(item):mount()

        if attempt > 1 then
          log.info(("Found non-premium problem after %d attempts"):format(attempt))
        end
      end
    end

    try_random()
  end
end

return {
  {
    "kawre/leetcode.nvim",
    cond = vim.fn.argv()[1] == leet_arg,
    lazy = false,
    keys = {
      { "<localleader>t", "<Cmd>Leet tabs<CR>" },
      { "<localleader>d", "<Cmd>Leet desc<CR>" },
      { "<localleader>D", "<Cmd>Leet daily<CR>" },
      { "<localleader><localleader>", "<Cmd>Leet run<CR>" },
      { "<localleader>r", random_with_retry(""), desc = "Random problem" },
      { "<localleader>e", random_with_retry("difficulty=Easy"), desc = "Random Easy" },
      { "<localleader>m", random_with_retry("difficulty=Medium"), desc = "Random Medium" },
      { "<localleader>h", random_with_retry("difficulty=Hard"), desc = "Random Hard" },
      { "<localleader>R", random_with_retry("status=todo"), desc = "Random TODO" },
      { "<localleader>E", random_with_retry("difficulty=Easy status=todo"), desc = "Random Easy TODO" },
      {
        "<localleader>M",
        random_with_retry("difficulty=Medium status=todo"),
        desc = "Random Medium TODO",
      },
      { "<localleader>H", random_with_retry("difficulty=Hard status=todo"), desc = "Random Hard TODO" },
      { "<localleader><cr>", "<Cmd>Leet submit<CR>" },
      { "<localleader>i", "<Cmd>Leet info<CR>" },
      { "<localleader>c", "<Cmd>Leet console<CR>" },
      { "<localleader>p", "<Cmd>Leet list<CR>" },
      { "<localleader>l", "<Cmd>Leet lang<CR>" },
      { "<localleader><space>", "<Cmd>Leet<CR>" },
    },
    opts = {
      hooks = {
        ["question_enter"] = {
          function()
            vim.opt.winfixbuf = false
          end,
        },
      },
      arg = leet_arg,
      lang = "golang",
      description = {
        width = "55%",
      },
      injector = {
        ["rust"] = {
          before = { "struct Solution {}" },
        },
        ["golang"] = {
          before = { "package main" },
        },
      },
      image_support = false,
    },
  },
}
