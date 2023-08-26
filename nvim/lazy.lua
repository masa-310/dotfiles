local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    "thinca/vim-quickrun",
    "alvan/vim-closetag",
    "honza/vim-snippets",
    {
      "L3MON4D3/LuaSnip",
      tag = "v1.2.1",
      -- build = "make install_jsregexp"
    },
    "tpope/vim-surround",
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",
    "ryanoasis/vim-devicons",
    "whonore/Coqtail",
    {"junegunn/fzf", build = "fzf#install()"},
    "junegunn/fzf.vim",
    "github/copilot.vim",
    "sheerun/vim-polyglot",
    "rgroli/other.nvim",
    "tjdevries/colorbuddy.nvim",
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
      config = function()
        require("mason").setup()
      end
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup {
            ensure_installed = {
              "elmls",
              "cssls",
              "jsonls",
              "gopls",
              "graphql",
              "lua_ls",
              "tsserver",
              -- "rnix",
              "rust_analyzer",
              "pyright",
              "sqls",
              "terraformls",
              "taplo",
              "tflint",
              "yamlls",
              "efm",
            }
        }
      end
    },
    {"neovim/nvim-lspconfig",
      dependencies = { "lukas-reineke/lsp-format.nvim",  "creativenull/efmls-configs-nvim" },
      config = function()

        local lspconfig = require("lspconfig")
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require("lsp-format").setup {}
        local on_attach = function(client)
            require("lsp-format").on_attach(client)
        end
        lspconfig.tsserver.setup{
          capabilities = capabilities,
          on_attach = on_attach
        }
        lspconfig.eslint.setup{
          capabilities = capabilities,
          on_attach = on_attach
        }
        lspconfig.gopls.setup{
          capabilities = capabilities,
          on_attach = on_attach
        }
        lspconfig.elmls.setup{
          capabilities = capabilities,
          on_attach = on_attach
        }
        lspconfig.rust_analyzer.setup {
          capabilities = capabilities,
          on_attach = on_attach
        }
        lspconfig.lua_ls.setup {
          capabilities = capabilities,
          on_attach = on_attach
        }

        -- efm
        local defaultLaungages = require('efmls-configs.defaults').languages()

        -- typescript
        local eslint = require('efmls-configs.linters.eslint')
        local prettier = require('efmls-configs.formatters.prettier')

        -- go
        local golangci_lint = require('efmls-configs.linters.golangci_lint')
        local gofmt = require('efmls-configs.formatters.gofmt')

        -- lua
        local stylua = require('efmls-configs.formatters.stylua')
        local customLanguages = {
          typescript = { prettier, eslint },
          go = { golangci_lint, gofmt },
          lua = { stylua },
        }

        local languages = vim.tbl_extend('force', defaultLaungages, customLanguages)

        local efmls_config = {
          filetypes = vim.tbl_keys(languages),
          settings = {
            rootMarkers = { '.git/' },
            languages = languages,
          },
          init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
          },
        }

        require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
          -- Pass your custom lsp config below like on_attach and capabilities
          on_attach = on_attach,
          capabilities = capabilities,
        }))

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
        vim.diagnostic.setqflist()

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<space>f', function()
              vim.lsp.buf.format { async = true }
            end, opts)
          end
        })
      end
    },
    -- {"nvim-tree/nvim-tree.lua",
    --   keys = {
    --     {"n", "<C-e>", ":NvimTreeToggle<CR>"},
    --     {"n", "<leader>r", ":NvimTreeRefresh<CR>"},
    --     {"n", "<leader>n", ":NvimTreeFindFile<CR>"},
    --   },
    --   config = function()
    --     require("nvim-tree").setup()
    --   end
    -- },
    {"stevearc/oil.nvim",
      opts = {},
      dependencies = { "nvim-tree/nvim-web-devicons" },
      keys = {
        {"<C-e>", ":Oil<CR>"},
      },
      config = function()
        require('oil').setup()
      end
    },
  "cohama/lexima.vim",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "petertriho/cmp-git",
  "saadparwaiz1/cmp_luasnip",
  {"hrsh7th/nvim-cmp",
    config = function()
      -- Set up nvim-cmp.
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
          { name = 'path' },
          { name = 'buffer' },
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  },
  { "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local metals_config = require("metals").bare_config()
      metals_config.init_options.statusBarProvider = "on"
      metals_config.settings = {
        showImplicitArguments = true,
        showInferredType = true,
      }
      -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Autocmd that will actually be in charging of starting the whole thing
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        -- NOTE: You may or may not want java included here. You will need it if you
        -- want basic Java support but it may also conflict if you are using
        -- something like nvim-jdtls which also works on a java filetype autocmd.
        pattern = { "scala", "sbt", "java" },
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  }
}, {
  performance = {
    rtp = {
      reset = false,
    },
  },
})
