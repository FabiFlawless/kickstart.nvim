-- CopilotChat.nvim - GitHub Copilot Chat Integration
-- Brings GitHub Copilot Chat capabilities directly into Neovim
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim

return {
  -- GitHub Copilot Chat integration
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" }, -- GitHub Copilot plugin
      { "nvim-lua/plenary.nvim", branch = "master" }, -- Required for curl, log and async functions
    },
    build = function()
      -- Build tiktoken for better token counting (Linux/MacOS only)
      if vim.fn.has("win32") == 0 then
        vim.fn.system("make tiktoken")
      end
    end,
    event = "VeryLazy",
    config = function()
      local select = require("CopilotChat.select")
      
      require("CopilotChat").setup({
        -- System prompt configuration
        system_prompt = 'COPILOT_INSTRUCTIONS',
        
        -- Model and agent settings
        model = 'gpt-4o', -- Use GPT-4o as default model
        agent = 'copilot',
        
        -- Performance settings
        temperature = 0.1,
        
        -- Debug settings (temporär aktivieren)
        debug = true,
        log_level = 'debug',
        
        -- Provider-Konfiguration für Agents
        providers = {
          copilot = {
            -- Explizit aktivieren
          },
          github_models = {
            -- GitHub Marketplace Models
          },
          copilot_embeddings = {
            -- Copilot Embeddings
          },
        },
        
        -- UI Configuration
        window = {
          layout = 'vertical', -- 'vertical', 'horizontal', 'float'
          width = 0.4, -- 40% of screen width
          height = 0.8, -- 80% of screen height
          border = 'rounded',
          title = '🤖 Copilot Chat',
          zindex = 100,
        },
        
        -- Enhanced selection strategy
        selection = function(source)
          return select.visual(source) or select.buffer(source)
        end,
        
        -- Display settings
        show_help = true,
        highlight_selection = true,
        highlight_headers = true,
        auto_follow_cursor = true,
        auto_insert_mode = true,
        clear_chat_on_new_prompt = false,
        
        -- Chat features
        chat_autocomplete = true,
        
        -- Alternative Agent-Simulation über sticky prompts
        sticky = {
          '> You are a specialized coding assistant with the following capabilities:',
          '> - Code analysis and review',
          '> - Go development expertise', 
          '> - Security and performance analysis',
          '> - Test generation and debugging',
          '> Please act as a knowledgeable agent for these tasks.',
        },
        contexts = {
          buffer = {},
          buffers = {},
          file = {},
          files = {},
          filenames = {},
          git = {},
          url = {},
          register = {},
          quickfix = {},
          system = {},
        },
        
        -- Custom prompts for Go development
        prompts = {
          -- Default prompts (keeping the originals)
          Explain = {
            prompt = 'Write an explanation for the selected code as paragraphs of text.',
            system_prompt = 'COPILOT_EXPLAIN',
            mapping = '<leader>cce',
            description = 'Explain code',
          },
          Review = {
            prompt = 'Review the selected code and suggest improvements.',
            system_prompt = 'COPILOT_REVIEW',
            mapping = '<leader>ccr',
            description = 'Review code',
          },
          Fix = {
            prompt = 'There is a problem in this code. Identify the issues and rewrite the code with fixes.',
            mapping = '<leader>ccf',
            description = 'Fix problems',
          },
          Optimize = {
            prompt = 'Optimize the selected code to improve performance and readability.',
            mapping = '<leader>cco',
            description = 'Optimize code',
          },
          Docs = {
            prompt = 'Please add documentation comments to the selected code.',
            mapping = '<leader>ccd',
            description = 'Add documentation',
          },
          Tests = {
            prompt = 'Please generate tests for my code.',
            mapping = '<leader>cct',
            description = 'Generate tests',
          },
          Commit = {
            prompt = 'Write commit message for the change with commitizen convention.',
            context = 'git:staged',
            mapping = '<leader>ccm',
            description = 'Generate commit message',
          },
          
          -- Custom Go-specific prompts
          GoRefactor = {
            prompt = 'Refactor this Go code to follow Go best practices and improve readability. Pay attention to error handling, naming conventions, and Go idioms.',
            system_prompt = 'You are an expert Go developer. Focus on Go-specific best practices, proper error handling, and idiomatic Go code.',
            mapping = '<leader>cgr',
            description = 'Refactor Go code',
          },
          GoError = {
            prompt = 'Help me improve error handling in this Go code. Suggest better error messages and handling strategies.',
            system_prompt = 'You are an expert in Go error handling patterns and best practices.',
            mapping = '<leader>cge',
            description = 'Improve Go error handling',
          },
          GoPerformance = {
            prompt = 'Analyze this Go code for performance issues and suggest optimizations.',
            system_prompt = 'You are a Go performance expert. Focus on memory usage, goroutines, and Go-specific optimizations.',
            mapping = '<leader>cgp',
            description = 'Go performance analysis',
          },
          GoSecurity = {
            prompt = 'Review this Go code for security vulnerabilities and suggest fixes.',
            system_prompt = 'You are a Go security expert. Look for common security issues in Go applications.',
            mapping = '<leader>cgs',
            description = 'Go security review',
          },
        },
        
        -- Enhanced mappings
        mappings = {
          complete = {
            insert = '<Tab>',
          },
          close = {
            normal = 'q',
            insert = '<C-c>',
          },        reset = {
          normal = '<C-r>',
          insert = '<C-r>',
        },
          submit_prompt = {
            normal = '<CR>',
            insert = '<C-s>',
          },
          toggle_sticky = {
            normal = 'grr',
          },
          clear_stickies = {
            normal = 'grx',
          },
          accept_diff = {
            normal = '<C-y>',
            insert = '<C-y>',
          },
          jump_to_diff = {
            normal = 'gj',
          },
          quickfix_answers = {
            normal = 'gqa',
          },
          quickfix_diffs = {
            normal = 'gqd',
          },
          yank_diff = {
            normal = 'gy',
            register = '"',
          },
          show_diff = {
            normal = 'gd',
            full_diff = false,
          },
          show_info = {
            normal = 'gi',
          },
          show_context = {
            normal = 'gc',
          },
          show_help = {
            normal = 'gh',
          },
        },
      })
      
      -- Global keybindings for CopilotChat
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
      end
      
      -- Main chat controls
      map('n', '<leader>cc', '<cmd>CopilotChat<cr>', 'Copilot: Open Chat')
      map('v', '<leader>cc', '<cmd>CopilotChat<cr>', 'Copilot: Chat with selection')
      map('n', '<leader>co', '<cmd>CopilotChatOpen<cr>', 'Copilot: Open Chat window')
      map('n', '<leader>cq', '<cmd>CopilotChatClose<cr>', 'Copilot: Close Chat window')
      map('n', '<leader>ct', '<cmd>CopilotChatToggle<cr>', 'Copilot: Toggle Chat window')
      map('n', '<leader>cs', '<cmd>CopilotChatStop<cr>', 'Copilot: Stop generation')
      map('n', '<leader>cr', '<cmd>CopilotChatReset<cr>', 'Copilot: Reset Chat')
      
      -- Quick actions
      map('v', '<leader>ce', '<cmd>CopilotChatExplain<cr>', 'Copilot: Explain selection')
      map('v', '<leader>cv', '<cmd>CopilotChatReview<cr>', 'Copilot: Review selection')
      map('v', '<leader>cf', '<cmd>CopilotChatFix<cr>', 'Copilot: Fix selection')
      map('v', '<leader>cd', '<cmd>CopilotChatDocs<cr>', 'Copilot: Document selection')
      map('v', '<leader>cp', '<cmd>CopilotChatOptimize<cr>', 'Copilot: Optimize selection')
      
      -- Selection and management
      map('n', '<leader>cP', '<cmd>CopilotChatPrompts<cr>', 'Copilot: Select Prompts')
      map('n', '<leader>cM', '<cmd>CopilotChatModels<cr>', 'Copilot: Select Models')
      map('n', '<leader>cA', '<cmd>CopilotChatAgents<cr>', 'Copilot: Select Agents')
      
      -- History management
      map('n', '<leader>ch', function()
        local input = vim.fn.input("Save chat as: ")
        if input ~= "" then
          require("CopilotChat").save(input)
        end
      end, 'Copilot: Save chat history')
      
      map('n', '<leader>cl', function()
        local input = vim.fn.input("Load chat: ")
        if input ~= "" then
          require("CopilotChat").load(input)
        end
      end, 'Copilot: Load chat history')
      
      -- Go-specific shortcuts (when in Go files)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          
          -- Go-specific chat shortcuts
          map('n', '<leader>cgr', '<cmd>CopilotChatGoRefactor<cr>', 'Copilot: Refactor Go code')
          map('v', '<leader>cgr', '<cmd>CopilotChatGoRefactor<cr>', 'Copilot: Refactor Go selection')
          map('n', '<leader>cge', '<cmd>CopilotChatGoError<cr>', 'Copilot: Improve Go error handling')
          map('v', '<leader>cge', '<cmd>CopilotChatGoError<cr>', 'Copilot: Improve Go error handling')
          map('n', '<leader>cgp', '<cmd>CopilotChatGoPerformance<cr>', 'Copilot: Go performance analysis')
          map('v', '<leader>cgp', '<cmd>CopilotChatGoPerformance<cr>', 'Copilot: Go performance analysis')
          map('n', '<leader>cgs', '<cmd>CopilotChatGoSecurity<cr>', 'Copilot: Go security review')
          map('v', '<leader>cgs', '<cmd>CopilotChatGoSecurity<cr>', 'Copilot: Go security review')
        end,
      })
      
      -- Auto-complete optimization for Neovim < 0.11.0
      if vim.fn.has('nvim-0.11.0') == 0 then
        vim.opt.completeopt:append('noinsert')
      end
      vim.opt.completeopt:append('popup')
    end,
  },

  -- GitHub Copilot base plugin (if not already installed)
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Basic Copilot settings
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      
      -- Copilot keybindings
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("")', {
        expr = true,
        replace_keycodes = false,
        desc = 'Accept Copilot suggestion'
      })
      
      vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)', {
        desc = 'Accept Copilot word'
      })
      
      vim.keymap.set('i', '<C-H>', '<Plug>(copilot-previous)', {
        desc = 'Previous Copilot suggestion'
      })
      
      vim.keymap.set('i', '<C-K>', '<Plug>(copilot-next)', {
        desc = 'Next Copilot suggestion'
      })
    end,
  },
}
