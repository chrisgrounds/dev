return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      enable_diagnostics = true,
      enable_git_status = true,
      popup_border_style = "rounded",
      sort_case_insensitive = false,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    },
  },
}
