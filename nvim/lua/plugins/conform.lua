return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        typescript = { "prettier" },
        javasript = { "prettier" },
      },
    },
  },
}
