local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Store the initial working directory when Neovim starts
local function get_git_dir_otherwise_cwd(cmd)
  local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  local cwd = vim.loop.cwd()
  if not handle then
    return cwd
  end

  local result = handle:read("*a")
  local success, exit_type, exit_code = handle:close()

  -- Trim any trailing whitespace from the result
  result = result:gsub("%s+$", "")

  if not success then
    return cwd
  end

  return result
end

local search_root = get_git_dir_otherwise_cwd()

vim.diagnostic.config({
  virtual_text = {
    spacing = 0,
    format = function(diagnostic)
      local code = "-"
      local source = "efm"
      if diagnostic.source ~= nil then
        source = diagnostic.source
      end
      if diagnostic.code ~= nil then
        code = diagnostic.code
      end
      return string.format("%s (%s: %s)", diagnostic.message, source, code)
    end,
  },
  underline = true,
  severity_sort = true,
  signs = true,
  update_in_insert = false,
})

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
  "github/copilot.vim",
  "rgroli/other.nvim",
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      require("transparent").setup({
        enable = true,
      })
    end,
  },
  "Zane-/cder.nvim",
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          wrap_results = true,
        },
        pickers = {
          oldfiles = {
            initial_mode = "normal",
          },
        },
        extensions = {
          cder = {
            dir_command = {
              "fd",
              "--exclude=.git/",
              "--exclude=go/",
              "--exclude=node_modules/",
              "--type=d",
              ".",
              search_root,
            },
            previewer_command = "eza -a --icons",
          },
        },
      })
      require("telescope").load_extension("cder")
      require("telescope").load_extension("projects")

      vim.api.nvim_create_autocmd(
        "FileType",
        { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] }
      )
    end,
    keys = {
      { "<C-p>", ":Telescope<CR>" },
      { "<C-s>", ":Telescope cder<CR>" },
      {
        "<C-j>",
        function()
          require("telescope.builtin").live_grep({
            cwd = search_root,
          })
        end,
      },
      {
        "<C-f>",
        function()
          require("telescope.builtin").find_files({
            cwd = search_root,
          })
        end,
      },
      {
        "<C-h>",
        function()
          require("telescope.builtin").oldfiles({
            cwd = search_root,
          })
        end,
      },
      { "<C-l>", ":lua require('telescope.builtin').buffers{}<CR>" },
      -- // { "<C-t>", ":lua require('trouble.open_with_trouble').open_with_trouble<CR>" },
      -- // { "<C-,>", ":lua require('trouble.open_with_trouble').open_with_trouble<CR>" },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          -- Defaults
          enable_close = true,           -- Auto close tags
          enable_rename = true,          -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        -- per_filetype = {
        -- 	["html"] = {
        -- 		enable_close = false,
        -- 	},
        -- },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = "TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  "davidmh/cspell.nvim",
  {
    "nvimtools/none-ls.nvim",

    config = function()
      local null_ls = require("null-ls")
      local cspell = require("cspell")

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      -- local on_attach = function(client, bufnr)
      --   if client.supports_method("textDocument/formatting") then
      --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       group = augroup,
      --       buffer = bufnr,
      --       callback = function()
      --         -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
      --         -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
      --         vim.lsp.buf.formatting_sync()
      --       end,
      --     })
      --   end
      -- end
      -- local on_attach = function(client)
      --   require("lsp-format").on_attach(client)
      -- end

      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.impl,
          null_ls.builtins.completion.luasnip,
          null_ls.builtins.completion.spell,
          null_ls.builtins.diagnostics.buf,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.terraform_validate,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.just,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.protolint,
          null_ls.builtins.formatting.purs_tidy,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.hover.dictionary,
          null_ls.builtins.hover.printenv,

          -- custom
          cspell.diagnostics.with({
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity["HINT"]
            end,
          }),
          cspell.code_actions,
        },

        -- on_attach = on_attach,
      })
    end,
  },
  "lukas-reineke/lsp-format.nvim",
  {
    "neovim/nvim-lspconfig",
    dependencies = { "nanotee/sqls.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local default_capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local capabilities = vim.tbl_extend("force", default_capabilities, cmp_capabilities)
      -- avoid performance degrading
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      require("lsp-format").setup({})
      local on_attach = function(client)
        require("lsp-format").on_attach(client)
      end
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
          documentFormatting = false,
        },
      })
      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        },
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.elmls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.hls.setup({
        filetypes = { "haskell", "lhaskell", "cabal" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.ccls.setup({
        filetypes = { "c", "cpp" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.purescriptls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.bufls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.metals.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "scala", "sbt" },
      })
      lspconfig.sqls.setup({
        cmd = { "sqls" },
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          require("sqls").on_attach(client, bufnr)
          local bufmap = vim.api.nvim_buf_set_keymap
          bufmap(bufnr, "n", "<LocalLeader>ss", "<cmd>SqlsExecuteQuery<CR>", { silent = true })
          bufmap(bufnr, "v", "<LocalLeader>ss", "<cmd>SqlsExecuteQuery<CR>", { silent = true })
        end,
        capabilities = capabilities,
        single_file_support = false,
        on_new_config = function(new_config, new_rootdir)
          new_config.cmd = {
            "sqls",
            "-config",
            new_rootdir .. "/.sqls.yml",
          }
        end,
      })

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
      vim.diagnostic.setqflist()

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    keys = {
      { "<C-e>", ":Oil --float<CR>" },
    },
    config = function()
      require("oil").setup({
        lsp_file_methods = {
          enabled = true,
          timeout_ms = 1000,
          autosave_changes = true,
        },
        view_options = {
          show_hidden = true,
        },
        float = {
          border = "none",

          winhl = "Normal",
          borderhl = "FloatBorder",

          winblend = 0,

          height = 0.8,
          width = 0.8,
          x = 0.5,
          y = 0.5,
        },
      })
    end,
  },
  "cohama/lexima.vim",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "petertriho/cmp-git",
  "saadparwaiz1/cmp_luasnip",
  {
    "hrsh7th/nvim-cmp",
    config = function()
      -- Set up nvim-cmp.
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_count = 100 },
          { name = "luasnip" }, -- For luasnip users.
          { name = "path" },
          { name = "buffer" },
        }),
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  {
    "is0n/jaq-nvim",
    keys = {
      { "<C-0>", ":Jaq<CR>" },
    },
    config = function()
      require("jaq-nvim").setup({
        cmds = {
          -- Uses vim commands
          internal = {
            lua = "luafile %",
            vim = "source %",
          },

          -- Uses shell commands
          external = {
            markdown = "glow %",
            python = "python3 %",
            go = "go run %",
            sh = "sh %",
            cpp = "g++ --std=c++20 % -o /tmp/out && /tmp/out",
          },
        },

        behavior = {
          -- Default type
          default = "bang",

          -- Start in insert mode
          startinsert = false,

          -- Use `wincmd p` on startup
          wincmd = false,

          -- Auto-save files
          autosave = false,
        },

        ui = {
          float = {
            -- See ':h nvim_open_win'
            border = "none",

            -- See ':h winhl'
            winhl = "Normal",
            borderhl = "FloatBorder",

            -- See ':h winblend'
            winblend = 0,

            -- Num from `0-1` for measurements
            height = 0.8,
            width = 0.8,
            x = 0.5,
            y = 0.5,
          },

          terminal = {
            -- Window position
            position = "bot",

            -- Window size
            size = 10,

            -- Disable line numbers
            line_no = false,
          },

          quickfix = {
            -- Window position
            position = "bot",

            -- Window size
            size = 10,
          },
        },
      })
    end,
  },
  "purescript-contrib/purescript-vim",
  --	{
  --		"iamcco/markdown-preview.nvim",
  --		config = function()
  --			vim.fn["mkdp#util#install"]()
  --		end,
  --	},
  --
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}, {
  performance = {
    rtp = {
      reset = false,
    },
  },
})
