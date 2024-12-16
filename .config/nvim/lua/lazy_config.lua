--
-- [[ lazy plugin manager installation ]]
--

local lazy_path = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  local lazy_repository = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 
	  'git', 
	  'clone', 
	  '--filter=blob:none', 
	  '--branch=stable', 
	  lazyrepo, 
	  lazypath 
  }
  if vim.v.shell_error ~= 0 then
    error('error: lazy.nvim repository could not be cloned:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazy_path)
