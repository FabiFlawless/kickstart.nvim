-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>e', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
    { '<leader>E', ':Neotree focus<CR>', desc = 'NeoTree focus', silent = true },
    { '<leader>ge', ':Neotree git_status<CR>', desc = 'NeoTree git status', silent = true },
    { '<leader>be', ':Neotree buffers<CR>', desc = 'NeoTree buffers', silent = true },
  },
  opts = {
    -- Global window configuration
    window = {
      position = "left",
      width = 50, -- Breiter für längere Dateinamen (war 40)
      mapping_options = {
        noremap = true,
        nowait = true,
      },
    },
    
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          -- Zusätzliche Mappings für bessere Navigation
          ['<C-x>'] = 'open_split',
          ['<C-v>'] = 'open_vsplit',
          ['<C-t>'] = 'open_tabnew',
          ['h'] = 'toggle_hidden',
          ['R'] = 'refresh',
        },
      },
      -- Bessere Anzeige für lange Dateinamen
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      hijack_netrw_behavior = "open_default",
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = false,
        hide_hidden = true,
        hide_by_name = {
          "node_modules"
        },
        hide_by_pattern = {
          "*.meta",
          "*/src/*/tsconfig.json",
        },
        always_show = {
          ".gitignored",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db"
        },
        never_show_by_pattern = {
          ".null-ls_*",
        },
      },
    },
    
    -- Icon-Konfiguration für bessere NerdFont-Unterstützung
    default_component_configs = {
      container = {
        enable_character_fade = true
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = nil,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = "󰈚",
        highlight = "NeoTreeFileIcon"
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          added     = "✚",
          modified  = "",
          deleted   = "✖",
          renamed   = "󰁕",
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        }
      },
      file_size = {
        enabled = true,
        required_width = 64,
      },
      type = {
        enabled = true,
        required_width = 122,
      },
      last_modified = {
        enabled = true,
        required_width = 88,
      },
      created = {
        enabled = true,
        required_width = 110,
      },
      symlink_target = {
        enabled = false,
      },
    },
    
    -- Buffers-Ansicht konfigurieren
    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = true,
      show_unloaded = true,
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        }
      },
    },
    
    -- Git-Status Ansicht
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"]  = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
          ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        }
      }
    }
  },
}
