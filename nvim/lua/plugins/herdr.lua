return {
  {
    "ChmaraX/herdr-nvim",
    opts = { keymaps = false },
    keys = {
      { "<leader>ax", function() require("herdr-nvim").comment_line() end, desc = "herdr-nvim: comment line" },
      { "<leader>ax", function() require("herdr-nvim").comment_selection() end, mode = "x", desc = "herdr-nvim: comment selection" },
      { "<leader>al", function() require("herdr-nvim").list_comments() end, desc = "herdr-nvim: list comments" },
      { "<leader>as", function() require("herdr-nvim").send_all({ submit = false }) end, desc = "herdr-nvim: paste comments to agent" },
      { "<leader>aS", function() require("herdr-nvim").send_all({ submit = true }) end, desc = "herdr-nvim: send comments to agent" },
    },
  },
}
