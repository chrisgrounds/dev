return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			variant = "moon",
			styles = {
				bold = true,
				transparency = false,
			},
			highlight_groups = {
				Visual = { fg = "#191724", bg = "#EBCC2D", inherit = false },
				Search = { fg = "#191724", bg = "#EBCC2D", inherit = false },
				CurSearch = { fg = "#191724", bg = "#EBCC2D", bold = true, inherit = false },
				IncSearch = { fg = "#191724", bg = "#EBCC2D", bold = true, inherit = false },
				Substitute = { fg = "#191724", bg = "#EBCC2D", bold = true, inherit = false },

				Boolean = { bold = true },
				Constant = { bold = true },
				Directory = { bold = true },
				Function = { bold = true },
				Identifier = { bold = true },
				Keyword = { bold = true },
				Label = { bold = true },
				Operator = { bold = true },
				Statement = { bold = true },
				Type = { bold = true },

				["@boolean"] = { bold = true },
				["@constant"] = { bold = true },
				["@function"] = { bold = true },
				["@function.call"] = { bold = true },
				["@keyword"] = { bold = true },
				["@keyword.operator"] = { bold = true },
				["@label"] = { bold = true },
				["@operator"] = { bold = true },
				["@type"] = { bold = true },
				["@variable.member"] = { bold = true },
			},
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "rose-pine",
		},
	},
}
