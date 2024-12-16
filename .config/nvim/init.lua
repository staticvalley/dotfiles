--
-- [[ basic options ]]
--

-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable nerdfonts
vim.g.have_nerd_font = false

-- enable line numbers
vim.opt.number = true
-- enable relative line numbers
vim.opt.relativenumber = true

-- enable mouse mode
vim.opt.mouse = "a"

-- only show mode in status line
vim.opt.showmode = false

-- sync clipboard between os and nvim.
--  see `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- create unlimited undo history directory
vim.opt.undodir = os.getenv("HOME") .. "/.undodir"
vim.opt.undofile = true

-- enable break indent
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- case-insensitive searching for lower case searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- enable signcolumn
vim.opt.signcolumn = "yes"

-- set update time lower
vim.opt.updatetime = 100

-- decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- sets how neovim will display certain whitespace characters in the editor.
--  see `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- preview substitutions when typing
vim.opt.inccommand = "split"

-- highlight current cursor line
vim.opt.cursorline = true

-- general cursor position when scrolling (from top of screen)
vim.opt.scrolloff = 10

--
-- [[ lazy configuration ]]
--

require("lazy_config")

--
-- [[ plugin configurations ]]
--

require("plugins")

--
-- [[ Keymaps ]]
--

require("keymaps")
