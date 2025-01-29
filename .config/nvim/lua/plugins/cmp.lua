--
-- nvim-cmp
--
-- https://github.com/hrsh7th/nvim-cmp/tree/main

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- snippet engine
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- conditional for regex support in snippets
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",

      -- add other nvim-cmp repos
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      -- see `:help cmp`
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      local lspkind = require("lspkind")
      local kind_icons = {
        Text = "  ",
        Method = "  ",
        Function = "  ",
        Constructor = "  ",
        Field = "  ",
        Variable = "  ",
        Class = "  ",
        Interface = "  ",
        Module = "  ",
        Property = "  ",
        Unit = "  ",
        Value = "  ",
        Enum = "  ",
        Keyword = "  ",
        Snippet = "  ",
        Color = "  ",
        File = "  ",
        Reference = "  ",
        Folder = "  ",
        EnumMember = "  ",
        Constant = "  ",
        Struct = "  ",
        Event = "  ",
        Operator = "  ",
        TypeParameter = "  ",
      }

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        window = {
          completion = cmp.config.window.bordered({
            border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:PmenuSel,Search:None",
            col_offset = -3,
            side_padding = 0,
            scrollbar = false,
            scrolloff = 10,
          }),
          documentation = cmp.config.window.bordered({
            border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:PmenuSel,Search:None",
          }),
        },
        formatting = {
          format = function(entry, vim_item)
            -- quick fix for the snippet indicator added to tokens
            if vim_item.abbr:sub(-1) == "~" then
              vim_item.abbr = vim_item.abbr:sub(1, -2)
            end

            -- trim token if too long
            local abbr_max_len = 20
            if #vim_item.abbr > abbr_max_len + 1 then
              vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, abbr_max_len) .. "..."
            end

            -- add icons and menu
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
          end,
        },
        experimental = {
          ghost_text = false,
        },
        mapping = cmp.mapping.preset.insert({
          -- see `:help ins-completion`

          -- select next item
          ["<C-j>"] = cmp.mapping.select_next_item(),
          -- select previous item
          ["<C-k>"] = cmp.mapping.select_prev_item(),

          -- scroll documentation display
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- accept autocompletion
          ["<C-Enter>"] = cmp.mapping.confirm({ select = true }),

          -- manually trigger completion
          ["<C-Space>"] = cmp.mapping.complete({}),
        }),
        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        },
      })
    end,
  },
}
