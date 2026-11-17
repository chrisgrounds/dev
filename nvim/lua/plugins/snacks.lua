return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          -- Dotfiles such as .env can also be Git-ignored, so enable both.
          files = { hidden = true, ignored = true },
          explorer = { hidden = true, ignored = true },
        },
      },
    },
  },
}
