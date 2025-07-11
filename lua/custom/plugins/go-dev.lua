-- Advanced Go Development Configuration
-- This plugin sets up a comprehensive Go development environment
--
-- Key Features:
-- 1. LSP with gopls for autocompletion, hover, goto definition
-- 2. DAP debugging with delve
-- 3. Testing with neotest
-- 4. Code formatting with gofumpt
-- 5. Linting with golangci-lint
--
-- Important Keybindings:
-- LSP: grd (definition), grr (references), K (hover), gra (code actions)
-- Go-specific: <leader>gr (run), <leader>gt (test), <leader>gf (format)
-- Debugging: F5 (start), F1-F3 (step), <leader>b (breakpoint)

return {
  -- Go.nvim - Comprehensive Go development plugin
  {
    'ray-x/go.nvim',
    dependencies = { 
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        -- Disable some default features to avoid conflicts
        goimports = 'gopls', -- Use gopls for imports instead of goimports
        fillstruct = 'gopls', -- Use gopls for struct filling
        gofmt = 'gofumpt', -- Use gofumpt for better formatting
        
        -- LSP settings
        lsp_cfg = false, -- Don't override LSP config, use our kickstart config
        lsp_gofumpt = true, -- Enable gofumpt via LSP
        lsp_on_attach = false, -- Don't override our LSP attach
        
        -- Diagnostic settings
        lsp_diag_hdlr = false, -- Use default diagnostic handler
        lsp_diag_virtual_text = { space = 0, prefix = "■" },
        lsp_diag_signs = true,
        lsp_diag_update_in_insert = false,
        
        -- Test settings
        test_runner = 'go', -- Use go test
        test_efm = true,
        test_timeout = '30s',
        
        -- Build settings
        build_tags = '',
        textobjects = true, -- Enable go textobjects
        
        -- Icons
        icons = { breakpoint = '●', currentpos = '▶' },
        
        -- Trouble integration
        trouble = true,
        luasnip = true, -- Enable luasnip integration
      })
      
      -- Go-specific keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = true, desc = 'Go: ' .. desc })
          end
          
          -- Go-specific commands
          map('<leader>gr', '<cmd>GoRun<cr>', '[R]un')
          map('<leader>gt', '<cmd>GoTest<cr>', '[T]est')
          map('<leader>gT', '<cmd>GoTestFunc<cr>', '[T]est Function')
          map('<leader>gc', '<cmd>GoCoverage<cr>', '[C]overage')
          map('<leader>gf', '<cmd>GoFmt<cr>', '[F]ormat')
          map('<leader>gi', '<cmd>GoImport<cr>', '[I]mports')
          map('<leader>gd', '<cmd>GoDoc<cr>', '[D]ocumentation')
          map('<leader>gs', '<cmd>GoFillStruct<cr>', 'Fill [S]truct')
          map('<leader>ge', '<cmd>GoIfErr<cr>', 'Add [E]rror check')
          map('<leader>ga', '<cmd>GoAddTag<cr>', '[A]dd Tags')
          map('<leader>gm', '<cmd>GoMod<cr>', '[M]od tidy')
        end,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- Install/update all Go tools
  },

  -- Enhanced DAP configuration for Go
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      require('dap-go').setup({
        delve = {
          -- On Windows, delve must be run attached or it crashes
          detached = vim.fn.has("win32") == 0,
          args = {},
          build_flags = "",
        },
        tests = {
          verbose = false,
        },
      })
    end,
  },

  -- Neotest for Go testing
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
    },
    ft = 'go',
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-go')({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" }
          })
        },
        -- Optional: Configure icons and output
        icons = {
          passed = "✓",
          running = "●",
          failed = "✗",
          unknown = "?",
        },
        floating = {
          border = "rounded",
          max_height = 0.6,
          max_width = 0.6,
        },
      })
    end,
  },

  -- Enhanced Treesitter for Go
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'go',
        'gomod',
        'gosum',
        'gowork',
        'gotmpl',
        'json',
        'sql',
        'comment'
      })
      return opts
    end,
  },

  -- Go.nvim integration with Mason
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- Go tools
        'gopls',
        'gofumpt',
        'golangci-lint',
        'gomodifytags',
        'gotests',
        'impl',
        'delve',
        'goimports',
        'iferr',
        'gotestsum',
        'gomvp',
        'govulncheck',
        'fillswitch',
      })
      return opts
    end,
  },
}
