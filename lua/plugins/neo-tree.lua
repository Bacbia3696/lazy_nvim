return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    open_files_do_not_replace_types = { "terminal", "trouble", "qf", "aerial", "edgy" },
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
          ["g?"] = "show_help",
          ["<C-b>"] = "noop",
          ["<C-f>"] = "noop",
          ["<C-u>"] = { "scroll_preview", config = { direction = 10 } },
          ["<C-d>"] = { "scroll_preview", config = { direction = -10 } },
          ["!"] = {
            function(state)
              vim.api.nvim_input(": " .. state.tree:get_node().path .. "<Home>")
            end,
            nowait = true,
          },
        },
      },
    },
  },
}
