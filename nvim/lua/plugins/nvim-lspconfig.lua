return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts = function()
      local ret = {
        tools = {
          runnables = {
            use_telescope = true,
          },
          inlay_hints = {
            auto = true,
            show_parameter_hints = true,
          },
        },
        autoformat = true,
        servers = {
          ["rust_analyzer"] = {
            settings = {
              ["rust_analyzer"] = {
                checkOnSave = {
                  command = "clippy",
                },
              },
            },
          },
        },
      }
      return ret
    end,
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },
}
