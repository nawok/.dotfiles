require('core.plugin_config.nvim-tree.keymaps')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function open_nvim_tree(data)
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
  local directory = vim.fn.isdirectory(data.file) == 1
  
  if not no_name and not directory then
    return
  end

  if directory then
    vim.cmd.cd(data.file)
  end

  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

require('nvim-tree').setup {
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        exclude = {
          filetype = { 'fugitive' },
          buftype = { 'terminal' }
        }
      }
    }
  },
  --auto_close = true,
  on_attach = on_attach, -- keymaps.lua
  open_on_tab = false,
  update_focused_file = {
    enable = true
  },
  filters = {
    custom = { ".git" }
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "icon",
    icons = {
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = false 
      },
      glyphs = {
        default = "",
        git = {
          unstaged = "○",
          staged = "●",
          unmerged = "⊜",
          renamed = "⊙",
          untracked = "⊕",
          deleted = "⊗",
          ignored = "⊘"
        },
        folder = {
          arrow_open = "▾",
          arrow_closed = "▸",
          default = "▸",
          open =  "▾",
          empty = "▸",
          empty_open = "▾",
          symlink = "▸",
          symlink_open = "▾",
        },
        --lsp = {
        --  warning = "⊗",
        --  error = "⊗",
        --}
      },
      padding = " ",
    },
    special_files = { "README.md", ".env" },
    root_folder_modifier = "':~'"
  },
  view = {
    side = 'right',
    width = 40
  },
  --lsp_diagnostics = true
}
