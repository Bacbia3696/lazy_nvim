vim.keymap.set("n", "r", require("rest-nvim").run, { buffer = true, desc = "Rest run current" })
vim.keymap.set("n", "<c-r>", require("rest-nvim").last, { buffer = true, desc = "Rest run all" })
vim.keymap.set("n", "K", "<Plug>RestNvimPreview", { buffer = true, desc = "Rest preview curl" })
