return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "gw",
        mode = { "n", "x", "o" },
        function()
          local Flash = require("flash")

          ---@param opts Flash.Format
          local function format(opts)
            return {
              { opts.match.label1, "FlashMatch" },
              { opts.match.label2, "FlashLabel" },
            }
          end

          Flash.jump({
            -- Label every word start immediately
            pattern = [[\<]],
            search = {
              mode = "search",
              multi_window = false,
            },
            label = {
              after = false,
              before = { 0, 0 },
              uppercase = false,
              format = format,
            },
            action = function(match, state)
              state:hide()

              Flash.jump({
                search = {
                  max_length = 0,
                  multi_window = false,
                },
                highlight = {
                  matches = false,
                },
                label = {
                  format = format,
                },
                matcher = function(win)
                  return vim.tbl_filter(function(m)
                    return m.label == match.label and m.win == win
                  end, state.results)
                end,
                labeler = function(matches)
                  for _, m in ipairs(matches) do
                    m.label = m.label2
                  end
                end,
              })
            end,
            labeler = function(matches, state)
              local labels = state:labels()

              for i, match in ipairs(matches) do
                match.label1 = labels[math.floor((i - 1) / #labels) + 1]
                match.label2 = labels[(i - 1) % #labels + 1]
                match.label = match.label1
              end
            end,
          })
        end,
        desc = "Flash Helix-style word jump",
      },
    },
  },
}
