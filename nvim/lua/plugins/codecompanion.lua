return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "openai",
          keymaps = {
            send = {
              modes = {
                n = { "<CR>" },
                i = nil,
              },
            },
            close = {
              modes = {
                n = "q",
                i = "<c-x>",
              },
            },
            stop = {
              modes = {
                n = "<c-x>",
              },
            },
          },
        },
        inline = {
          adapter = "openai",
        },
        agent = {
          adapter = "openai",
        },
      },
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = {
              model = {
                default = "deepseek-coder-v2",
              },
            },
            env = {
              api_key = "cmd: cat ~/.config/openai/key",
            },
          })
        end,
      },
    })
    vim.api.nvim_set_keymap("n", "<c-l>", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<c-l>", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionAdd<cr>", { noremap = true, silent = true })
  end,
}
