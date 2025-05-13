-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local autocmd = vim.api.nvim_create_autocmd

-- Only show inlay_hint when in normal mode
autocmd({ "LspAttach", "InsertEnter", "InsertLeave" }, {
  callback = function(args)
    local enabled = args.event ~= "InsertEnter"
    vim.lsp.inlay_hint.enable(enabled, { bufnr = args.buf })
  end,
})
