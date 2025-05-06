-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set('n', '<leader>ca',
  function()
    vim.lsp.buf.code_action({apply = true})
  end,
  { desc = "Code action" }
)
