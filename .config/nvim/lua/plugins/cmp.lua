--
-- nvim-cmp
--
-- https://github.com/hrsh7th/nvim-cmp/tree/main

return {
  { 
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- snippet engine
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- conditional for regex support in snippets
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- add other nvim-cmp repos
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- see `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          -- see `:help ins-completion`

          -- select next item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- select previous item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- scroll documentation display
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- accept autocompletion
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- manually trigger completion
          ['<C-Space>'] = cmp.mapping.complete {},
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
}
