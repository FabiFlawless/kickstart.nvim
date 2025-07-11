-- Go-specific configuration and plugins
-- This file optimizes Neovim for Go development

return {
  -- Go LSP and tooling
  {
    'neovim/nvim-lspconfig',
    opts = function()
      return {
        servers = {
          gopls = {
            settings = {
              gopls = {
                -- Enable more features
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-server", "-node_modules" },
                semanticTokens = true,
                analyses = {
                  unusedparams = true,
                  shadow = true,
                  fieldalignment = true,
                  nilness = true,
                },
                codelenses = {
                  gc_details = false,
                  generate = true,
                  regenerate_cgo = true,
                  run_govulncheck = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
              },
            },
          },
        },
      }
    end,
  },

  -- Go-specific plugins for enhanced development
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        -- Disable default keymaps since we'll define our own
        disable_defaults = false,
        -- Auto format and organize imports on save
        goimports = 'gopls',
        gofmt = 'gofumpt', -- Use gofumpt for better formatting
        max_line_len = 120,
        tag_transform = false,
        test_dir = '',
        comment_placeholder = '   ',
        lsp_cfg = false, -- We configure LSP separately
        lsp_gofumpt = true,
        lsp_on_attach = false, -- We handle this in our LSP config
        dap_debug = true,
        dap_debug_keymap = false, -- We'll set custom keymaps
        -- Test settings
        test_runner = 'go', -- Use go test
        run_in_floaterm = false,
        -- Icons (only if you have a nerd font)
        icons = { 
          breakpoint = '🧘', 
          currentpos = '🏃',
        },
        -- Verbose mode for debugging
        verbose = false,
        log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
  },

  -- Enhanced Go testing
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-go')({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s", "-race", "-cover" }
          }),
        },
        discovery = {
          enabled = false,
        },
        running = {
          concurrent = true,
        },
        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
        },
      })
    end,
    ft = { "go" },
  },

  -- Go-specific Treesitter configuration
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'go', 'gomod', 'gowork', 'gosum' })
    end,
  },

  -- Go formatting and linting
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.go = { "goimports", "gofumpt" }
    end,
  },

  -- Go linting
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.go = { 'golangcilint' }
    end,
  },
}
