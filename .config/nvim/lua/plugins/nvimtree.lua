
return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  -- dependencies = {
  --   'nvim-tree/nvim-web-devicons',
  -- },
  config = function()
    -- Using protected call
    local status_ok, nvim_tree = pcall(require, 'nvim-tree')
    if not status_ok then
      return
    end

    nvim_tree.setup {
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      renderer = {
        add_trailing = true,
        group_empty = true,
        root_folder_modifier = ':t',
        icons = {
          show = {
            file = false,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = false,
          },
          glyphs = {
            default = '',
            symlink = '',
            folder = {
              arrow_open = '▼',
              arrow_closed = '▶',
              default = '',
              open = '',
              empty = '',
              empty_open = '',
              symlink = '',
              symlink_open = '',
            },
            git = {
              unstaged = '[M]',
              staged = '[M]',
              unmerged = ' ',
              renamed = '[R]',
              untracked = '[?]',
              deleted = '[D]',
              ignored = '[I]',
            },
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = 'H',
          info = 'I',
          warning = 'W',
          error = 'E',
        },
      },
      view = {
        width = 40,
        side = 'left',
      },
    }

    -- Setting Keymaps
    vim.keymap.set('n', '<leader>1', ':NvimTreeToggle<CR>', { silent = true, desc = "Tree - Open/Close tree" })
    vim.keymap.set('n', '<leader>2', ':NvimTreeFindFile<CR>', { silent = true, desc = "Tree - Locate current file in tree" })
  end,
}

