return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    open_files_do_not_replace_types = { "terminal", "trouble", "qf", "aerial" }, -- when opening files, do not use windows containing these filetypes or buftypes
    window = {
      width = 30,
    },
    -- Equalize Window Sizes on Neo-tree Open and Close
    event_handlers = {
      {
        event = "neo_tree_window_after_open",
        handler = function(args)
          if args.position == "left" or args.position == "right" then
            vim.cmd("wincmd =")
          end
        end,
      },
      {
        event = "neo_tree_window_after_close",
        handler = function(args)
          if args.position == "left" or args.position == "right" then
            vim.cmd("wincmd =")
          end
        end,
      },
    },
    filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
      },
      follow_current_file = { enabled = true, leave_dirs_open = true },
      window = {
        mappings = {
          ["/"] = "noop",
          ["?"] = "noop",
          ["oc"] = "noop",
          ["od"] = "noop",
          ["og"] = "noop",
          ["om"] = "noop",
          ["on"] = "noop",
          ["os"] = "noop",
          ["ot"] = "noop",
          ["<C-b>"] = "noop",
          ["<C-f>"] = "noop",

          ["<C-u>"] = { "scroll_preview", config = {direction = 10} },
          ["<C-d>"] = { "scroll_preview", config = {direction = -10} },
          ["g?"] = "show_help",
          ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
          ["Oc"] = { "order_by_created", nowait = false },
          ["Od"] = { "order_by_diagnostics", nowait = false },
          ["Og"] = { "order_by_git_status", nowait = false },
          ["Om"] = { "order_by_modified", nowait = false },
          ["On"] = { "order_by_name", nowait = false },
          ["Os"] = { "order_by_size", nowait = false },
          ["Ot"] = { "order_by_type", nowait = false },
          ["o"] = {
            function(state)
              local node = state.tree:get_node()
              if vim.list_contains({ "jpg", "png", "jpeg" }, node.ext) then
                vim.ui.open(node.path)
              else
                state.commands.open(state)
              end
            end,
            nowait = true,
          },
          ["!"] = {
            function(state)
              vim.api.nvim_input(": " .. state.tree:get_node().path .. "<Home>")
            end,
            nowait = true,
          },
          ["Y"] = {
            function(state)
              require("helpers").copy(state.tree:get_node().path)
            end,
            nowait = true,
          },
        },
      },
    },
  },
}
