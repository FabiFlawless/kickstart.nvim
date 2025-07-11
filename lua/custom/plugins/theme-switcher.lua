-- Theme Switcher Configuration
-- This file provides easy theme switching capabilities

return {
  -- Telescope extension for color scheme preview
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = function(_, opts)
      opts = opts or {}
      opts.extensions = opts.extensions or {}
      opts.extensions["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        }
      }
      return opts
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("ui-select")
    end,
  },

  -- Theme switcher configuration
  {
    "nvim-lua/plenary.nvim", -- Required for file operations
    config = function()
      -- Function to set colorscheme and save preference
      local function set_colorscheme(name)
  vim.cmd.colorscheme(name)
  -- Save the preference to a file
  local config_file = vim.fn.stdpath('data') .. '/last_colorscheme.txt'
  local file = io.open(config_file, 'w')
  if file then
    file:write(name)
    file:close()
  end
  vim.notify("Colorscheme set to: " .. name, vim.log.levels.INFO)
end

-- Function to load last used colorscheme
local function load_last_colorscheme()
  local config_file = vim.fn.stdpath('data') .. '/last_colorscheme.txt'
  local file = io.open(config_file, 'r')
  if file then
    local last_scheme = file:read('*a'):gsub('%s+', '')
    file:close()
    if last_scheme and last_scheme ~= '' then
      pcall(vim.cmd.colorscheme, last_scheme)
      return last_scheme
    end
  end
  return nil
end

-- Try to load last colorscheme, fallback to tokyonight-night
vim.defer_fn(function()
  local last_scheme = load_last_colorscheme()
  if not last_scheme then
    set_colorscheme('tokyonight-night')
  end
end, 100)

-- Create user commands for easy theme switching
vim.api.nvim_create_user_command('ThemeGruvbox', function() set_colorscheme('gruvbox') end, {})
vim.api.nvim_create_user_command('ThemeCatppuccin', function() set_colorscheme('catppuccin') end, {})
vim.api.nvim_create_user_command('ThemeCatppuccinLatte', function() set_colorscheme('catppuccin-latte') end, {})
vim.api.nvim_create_user_command('ThemeCatppuccinFrappe', function() set_colorscheme('catppuccin-frappe') end, {})
vim.api.nvim_create_user_command('ThemeCatppuccinMacchiato', function() set_colorscheme('catppuccin-macchiato') end, {})
vim.api.nvim_create_user_command('ThemeCatppuccinMocha', function() set_colorscheme('catppuccin-mocha') end, {})
vim.api.nvim_create_user_command('ThemeNord', function() set_colorscheme('nord') end, {})
vim.api.nvim_create_user_command('ThemeDracula', function() set_colorscheme('dracula') end, {})
vim.api.nvim_create_user_command('ThemeOneDark', function() set_colorscheme('onedark') end, {})
vim.api.nvim_create_user_command('ThemeNightfox', function() set_colorscheme('nightfox') end, {})
vim.api.nvim_create_user_command('ThemeRosePine', function() set_colorscheme('rose-pine') end, {})
vim.api.nvim_create_user_command('ThemeRosePineMoon', function() set_colorscheme('rose-pine-moon') end, {})
vim.api.nvim_create_user_command('ThemeRosePineDawn', function() set_colorscheme('rose-pine-dawn') end, {})
vim.api.nvim_create_user_command('ThemeKanagawa', function() set_colorscheme('kanagawa') end, {})
vim.api.nvim_create_user_command('ThemeKanagawaWave', function() set_colorscheme('kanagawa-wave') end, {})
vim.api.nvim_create_user_command('ThemeKanagawaDragon', function() set_colorscheme('kanagawa-dragon') end, {})
vim.api.nvim_create_user_command('ThemeKanagawaLotus', function() set_colorscheme('kanagawa-lotus') end, {})
vim.api.nvim_create_user_command('ThemeMaterial', function() set_colorscheme('material') end, {})
vim.api.nvim_create_user_command('ThemeMaterialDeeper', function() set_colorscheme('material-deeper-ocean') end, {})
vim.api.nvim_create_user_command('ThemeMaterialOceanic', function() set_colorscheme('material-oceanic') end, {})
vim.api.nvim_create_user_command('ThemeMaterialPalenight', function() set_colorscheme('material-palenight') end, {})
vim.api.nvim_create_user_command('ThemeTokyonight', function() set_colorscheme('tokyonight') end, {})
vim.api.nvim_create_user_command('ThemeTokyonightNight', function() set_colorscheme('tokyonight-night') end, {})
vim.api.nvim_create_user_command('ThemeTokyonightStorm', function() set_colorscheme('tokyonight-storm') end, {})
vim.api.nvim_create_user_command('ThemeTokyonightDay', function() set_colorscheme('tokyonight-day') end, {})

-- Keybindings for theme switching
      vim.keymap.set('n', '<leader>th', '<cmd>Telescope colorscheme<cr>', { desc = 'Select [Th]eme' })
      vim.keymap.set('n', '<leader>tg', '<cmd>ThemeGruvbox<cr>', { desc = '[T]heme [G]ruvbox' })
      vim.keymap.set('n', '<leader>tc', '<cmd>ThemeCatppuccin<cr>', { desc = '[T]heme [C]atppuccin' })
      vim.keymap.set('n', '<leader>tn', '<cmd>ThemeNord<cr>', { desc = '[T]heme [N]ord' })
      vim.keymap.set('n', '<leader>td', '<cmd>ThemeDracula<cr>', { desc = '[T]heme [D]racula' })
      vim.keymap.set('n', '<leader>to', '<cmd>ThemeOneDark<cr>', { desc = '[T]heme [O]neDark' })
      vim.keymap.set('n', '<leader>tr', '<cmd>ThemeRosePine<cr>', { desc = '[T]heme [R]ose Pine' })
      vim.keymap.set('n', '<leader>tk', '<cmd>ThemeKanagawa<cr>', { desc = '[T]heme [K]anagawa' })
      vim.keymap.set('n', '<leader>tm', '<cmd>ThemeMaterial<cr>', { desc = '[T]heme [M]aterial' })
      vim.keymap.set('n', '<leader>tt', '<cmd>ThemeTokyonightNight<cr>', { desc = '[T]heme [T]okyonight' })

      -- Add which-key groups for theme switching
      if pcall(require, 'which-key') then
        require('which-key').add({
          { "<leader>t", group = "[T]hemes" },
        })
      end

      -- Load last used colorscheme on startup
      load_last_colorscheme()
    end,
  },
}
