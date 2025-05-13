-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local wk = require("which-key")
-- ai keys
wk.add({
  { "<leader>a", group = "ai" },
})
map("n", "<leader>ak", "<cmd>CodeCompanion<cr>", { desc = "Edit" })
map("n", "<leader>ac", "<cmd>CodeCompanionChat<cr>", { desc = "Chat" })
map("v", "<leader>ak", "<cmd>'<,'>CodeCompanion<cr>", { desc = "Edit" })
map("v", "<leader>ac", "<cmd>'<,'>CodeCompanionChat<cr>", { desc = "Chat" })

map("n", "<leader>ca", function()
  vim.lsp.buf.code_action({ apply = true })
end, { desc = "Code action" })
