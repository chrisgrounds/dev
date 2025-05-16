return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      style = "storm",
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(highlights, colors)
        highlights.LspInlayHint = {
          fg = colors.comment,
          bg = "NONE",
          italic = true,
        }
      end,
    },
  },
}
