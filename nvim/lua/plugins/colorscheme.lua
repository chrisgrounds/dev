return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
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
