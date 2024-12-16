--
-- [[ plugin configurations ]]
--

require("lazy").setup({

	--
	-- [ themes/style ]
	--

	-- editor theme
	require("theme/kanagawa"),

	--
	-- [ small plugins ]
	--

	-- adjust shiftwidth/tabstop automatically
	"tpope/vim-sleuth",

	--
	-- [ large plugins ]
	--

	-- git gutter decorations
	require("plugins/gitsigns"),

	-- keybind visualizer
	require("plugins/whichkey"),

	-- fuzzy finder
	require("plugins/telescope"),

	-- lsp config
	require("plugins/lsp_config"),

	-- autoformatting
	require("plugins/conform"),

	-- autocompletion
	require("plugins/cmp"),

	-- syntax highlighting
	require("plugins/treesitter"),
})
