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
    "neovim/nvim-lspconfig",
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
              "eslint",
              "cssls",
              "jsonls",
              "gopls",
              "golangci_lint_ls",
              "graphql",
              -- "luals",
              "tsserver",
              -- "rnix",
              "rust_analyzer",
              "pyright",
              "sqls",
              "terraformls",
              "taplo",
              "tflint",
              "yamlls",
            }
        }
      end
    },
    {"neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        lspconfig.tsserver.setup{}
        lspconfig.eslint.setup{}
        lspconfig.gopls.setup{}
        lspconfig.elmls.setup{}

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

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
    {"mfussenegger/nvim-lint",
      config = function()
        require('lint').linters_by_ft = {
          javascript = {'eslint'},
          javascriptreact = {'eslint'},
          typescript = {'eslint'},
          typescriptreact = {'eslint'},
          -- lua = {'luacheck'},
          go = {'golangcilint'},
          -- yaml = {'yamllint'},
          -- json = {'jsonlint'},
          -- markdown = {'markdownlint'},
          -- nix = {'nix'},
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          callback = function()
            require("lint").try_lint()
          end,
        })
      end
    },
    {"mhartington/formatter.nvim",
        config = function()
          local util = require "formatter.util"
          local prettier = {
            function()
              return {
                exe = "prettier",
                args = {"--stdin-filepath",  util.escape_path(util.get_current_buffer_file_path())},
                stdin = true
              }
            end
          }
          require('formatter').setup()
        end
      }
}, {
  performance = {
    rtp = {
      reset = false,
    },
  },
})
