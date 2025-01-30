--
-- language server protocol plugins
--

return {
  {
    --
    -- lazydev
    --
    -- https://github.com/folke/lazydev.nvim
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    --
    -- lsp config
    --
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    dependencies = {
      --
      -- lsp package manager [mason]
      --
      -- https://github.com/williamboman/mason.nvim
      {
        "williamboman/mason.nvim",
        config = true,
      },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      --
      -- lsp progress messages
      --
      -- https://github.com/j-hui/fidget.nvim
      {
        "j-hui/fidget.nvim",
        opts = {},
      },

      -- autocompletion integration
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          -- map key to lsp function
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- jump to current focused object's definition
          -- <C-t> to return from goto call
          map("gd", require("telescope.builtin").lsp_definitions, "goto object definition")

          -- find references of current focused object
          map("gr", require("telescope.builtin").lsp_references, "goto object references")

          -- jump to current focused object's type definition
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "jump to object definition")

          -- fuzzy find all occurances of symbol in current document
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "list all symbols in current document")

          -- fuzzy find all occurances of symbol in entire workspace
          map(
            "<leader>ws",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            "list all symbols in entire workspace"
          )

          -- rename current focused object
          map("<leader>rn", vim.lsp.buf.rename, "rename object in place")

          -- execute lsp code action [suggestions, errors]
          map("<leader>ca", vim.lsp.buf.code_action, "execute code action", { "n", "x" })

          -- jump to current object's declaration
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- cursor hold autohighlighting
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd(
              { "CursorHold", "CursorHoldI" },
              { buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.document_highlight }
            )

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- display inline hints in code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- add nvim cmp capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        --
        -- specific server configurations
        --
        -- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
        -- overwritable features:
        --  - cmd:          initialization commad
        --  - filetypes:    associated filetypes
        --  - capabilities: disable/enable lsp features
        --  - settings:     settigns for lsp server

        rust_analyzer = {},

        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--all-scopes-completion",
            "--pch-storage=memory",
            "--offset-encoding=utf-16", -- Needed for null-ls
            "--enable-config", -- Needed to load .clangd config file
            "--header-insertion-decorators",
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
          init_options = {
            compilationDatabasePath = "build",
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true,
          },
          settings = {
            ["clangd"] = {
              documentation = {
                showASTInlays = true,
                showSourceInlays = true,
              },
              typeHierarchy = {
                resolveRelations = true,
              },
              completion = {
                placeholder = true,
                detailedLabel = true,
              },
              crossFileRename = true,
              detectExtensionConflicts = true,
            },
          },
        },

        lua_ls = {
          filetypes = { "lua" },
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
      }
      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      -- enforces 'capabilities' list during lsp initialization
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
