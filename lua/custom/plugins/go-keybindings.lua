-- Go-specific keybindings and commands
-- This file adds convenient keybindings for Go development

-- Utility function to toggle hover window
local function toggle_hover()
  -- Check if there's already a floating window open
  local floating_windows = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then
      table.insert(floating_windows, win)
    end
  end
  
  -- If there are floating windows, close them
  if #floating_windows > 0 then
    for _, win in ipairs(floating_windows) do
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, false)
      end
    end
  else
    -- No floating windows, show hover
    vim.lsp.buf.hover()
  end
end

-- Set up Go-specific keybindings when a Go file is opened
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Helper function to set buffer-specific keymaps
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
    end

    -- ===== LSP-basierte Keybindings für Hover und Definition =====
    -- Diese funktionieren mit gopls und zeigen Informationen über Funktionen/Structs
    map('n', 'K', toggle_hover, 'Go: Toggle hover information (function/struct details)')
    map('n', 'gd', vim.lsp.buf.definition, 'Go: [G]o to [D]efinition')
    map('n', 'gD', vim.lsp.buf.declaration, 'Go: [G]o to [D]eclaration')
    map('n', 'gi', vim.lsp.buf.implementation, 'Go: [G]o to [I]mplementation')
    map('n', 'gr', require('telescope.builtin').lsp_references, 'Go: [G]o to [R]eferences')
    map('n', 'gt', vim.lsp.buf.type_definition, 'Go: [G]o to [T]ype Definition')
    
    -- Symbol navigation
    map('n', '<leader>gs', require('telescope.builtin').lsp_document_symbols, 'Go: [G]o [S]ymbols in document')
    map('n', '<leader>gS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Go: [G]o [S]ymbols in workspace')

    -- ===== Go.nvim spezifische Commands =====
    -- Struct manipulation
    map('n', '<leader>gat', '<cmd>GoAddTag<cr>', 'Go: [A]dd [T]ags to struct')
    map('n', '<leader>grt', '<cmd>GoRmTag<cr>', 'Go: [R]emove [T]ags from struct')
    map('n', '<leader>gfs', '<cmd>GoFillStruct<cr>', 'Go: [F]ill [S]truct')
    map('n', '<leader>gfS', '<cmd>GoFillSwitch<cr>', 'Go: [F]ill [S]witch statement')
    
    -- Code generation
    map('n', '<leader>gie', '<cmd>GoIfErr<cr>', 'Go: Generate [I]f [E]rr snippet')
    map('n', '<leader>gim', '<cmd>GoImpl<cr>', 'Go: [I]mplement [M]ethod for interface')

    -- ===== Testing commands =====
    map('n', '<leader>gtt', '<cmd>GoTest<cr>', 'Go: Run [T]est')
    map('n', '<leader>gtf', '<cmd>GoTestFunc<cr>', 'Go: Run [T]est [F]unction')
    map('n', '<leader>gtF', '<cmd>GoTestFile<cr>', 'Go: Run [T]est [F]ile')
    map('n', '<leader>gtp', '<cmd>GoTestPkg<cr>', 'Go: Run [T]est [P]ackage')
    map('n', '<leader>gta', '<cmd>GoTestAll<cr>', 'Go: Run [T]est [A]ll')
    map('n', '<leader>gtc', '<cmd>GoCoverage<cr>', 'Go: Show [T]est [C]overage')
    map('n', '<leader>gtv', '<cmd>GoCoverageToggle<cr>', 'Go: Toggle [T]est Co[v]erage')

    -- ===== Build and run commands =====
    map('n', '<leader>gb', '<cmd>GoBuild<cr>', 'Go: [B]uild')
    map('n', '<leader>gr', '<cmd>GoRun<cr>', 'Go: [R]un')
    map('n', '<leader>gR', '<cmd>GoRun %<cr>', 'Go: [R]un current file')

    -- ===== Debug commands (uses nvim-dap) =====
    map('n', '<leader>gdt', '<cmd>lua require("dap-go").debug_test()<cr>', 'Go: [D]ebug [T]est')
    map('n', '<leader>gdl', '<cmd>lua require("dap-go").debug_last_test()<cr>', 'Go: [D]ebug [L]ast test')

    -- ===== Format and organize imports =====
    map('n', '<leader>gf', '<cmd>GoFmt<cr>', 'Go: [F]ormat file')
    map('n', '<leader>go', '<cmd>GoImports<cr>', 'Go: [O]rganize imports')
    map('n', '<leader>gF', function() vim.lsp.buf.format() end, 'Go: [F]ormat with LSP')

    -- ===== Generate commands =====
    map('n', '<leader>ggm', '<cmd>GoGenerate<cr>', 'Go: [G]enerate ([M]ake)')
    map('n', '<leader>ggt', '<cmd>GoAlt<cr>', 'Go: [G]o to [T]est file')
    map('n', '<leader>ggc', '<cmd>GoCallers<cr>', 'Go: Show [C]allers')
    map('n', '<leader>ggd', '<cmd>GoCallees<cr>', 'Go: Show Calle[d] functions')

    -- ===== Documentation and help =====
    map('n', '<leader>gh', '<cmd>GoDoc<cr>', 'Go: Show [H]elp/Documentation')

    -- ===== Neotest keybindings for Go =====
    if pcall(require, 'neotest') then
      map('n', '<leader>gnt', '<cmd>lua require("neotest").run.run()<cr>', 'Go: [N]eotest run [T]est')
      map('n', '<leader>gnf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', 'Go: [N]eotest run [F]ile')
      map('n', '<leader>gnd', '<cmd>lua require("neotest").run.run({strategy = "dap"})<cr>', 'Go: [N]eotest [D]ebug test')
      map('n', '<leader>gns', '<cmd>lua require("neotest").summary.toggle()<cr>', 'Go: [N]eotest [S]ummary')
      map('n', '<leader>gno', '<cmd>lua require("neotest").output.open({enter = true})<cr>', 'Go: [N]eotest [O]utput')
    end

    -- ===== LSP Code Actions =====
    map('n', '<leader>gca', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Go: [C]ode [A]ction')
    map('n', '<leader>gcr', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Go: [C]ode [R]ename')
    
    -- ===== Quick navigation =====
    map('n', '<leader>ge', '<cmd>GoIfErr<cr>', 'Go: Add [E]rror handling')
    map('n', '<leader>gj', '<cmd>GoDoc<cr>', 'Go: Show documentation (alternative)')
  end,
})

-- Global Go-related keybindings (work from any filetype)
vim.keymap.set('n', '<leader>Gt', '<cmd>GoTestAll<cr>', { desc = 'Go: Run all tests in project' })
vim.keymap.set('n', '<leader>Gb', '<cmd>GoBuild %:h<cr>', { desc = 'Go: Build current package' })

-- Set up which-key groups for better organization
if pcall(require, 'which-key') then
  require('which-key').add({
    { "<leader>g", group = "[G]o Development" },
    { "<leader>ga", group = "[G]o [A]dd" },
    { "<leader>gr", group = "[G]o [R]un/Remove" },
    { "<leader>gf", group = "[G]o [F]ormat/Fill" },
    { "<leader>gi", group = "[G]o [I]mport/Implement" },
    { "<leader>gt", group = "[G]o [T]est" },
    { "<leader>gd", group = "[G]o [D]ebug/Definition" },
    { "<leader>gg", group = "[G]o [G]enerate" },
    { "<leader>gn", group = "[G]o [N]eotest" },
    { "<leader>gc", group = "[G]o [C]ode" },
    
    -- CopilotChat groups
    { "<leader>c", group = "[C]opilot Chat" },
    { "<leader>cc", group = "[C]opilot [C]hat" },
    { "<leader>cg", group = "[C]opilot [G]o Specific" },
  })
end

return {}
