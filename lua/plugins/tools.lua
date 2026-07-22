return {
  {
    "ramilito/kubectl.nvim",
    -- use a release tag to download pre-built binaries
    version = "2.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    dependencies = "saghen/blink.download",
    opts = {},
  },
  {
    "mistricky/codesnap.nvim",
    cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapASCII" },
    opts = {
      bg_padding = 0,
      watermark = "",
    },
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>-",
        "<cmd>Yazi toggle<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },

