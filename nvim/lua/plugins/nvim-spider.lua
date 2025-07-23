return {
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    config = function()
      require("spider").setup({
        skipInsignificantPunctuation = true,
        subwordMovement = true,
      })
    end,
  },
}

