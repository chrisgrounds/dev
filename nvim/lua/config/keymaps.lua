vim.keymap.set("i", "jk", "<Esc>", { noremap = true })

vim.keymap.set({ "n", "v" }, "<ScrollWheelDown>", "<C-e>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<ScrollWheelUp>", "<C-y>", { noremap = true, silent = true })
vim.keymap.set("i", "<ScrollWheelDown>", "<C-o><C-e>", { noremap = true, silent = true })
vim.keymap.set("i", "<ScrollWheelUp>", "<C-o><C-y>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>gB", function()
  require("gitsigns").blame()
end, { desc = "Blame Buffer" })
