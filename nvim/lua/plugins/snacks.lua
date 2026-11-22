return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          -- Dotfiles such as .env can also be Git-ignored, so enable both,
          -- while still excluding Rust build artifacts in target/.
          files = { hidden = true, ignored = true, exclude = { "target" } },
          explorer = { hidden = true, ignored = true, exclude = { "target" } },
        },
      },
    },
  },
}
