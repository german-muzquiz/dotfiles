
local keymap = vim.keymap.set

-- Format XML
keymap('n', '<leader>r', ':%s/&lt;/</g<CR> :%s/&gt;/>/g<CR> :%s/></>\r</g<CR> :syntax off<CR> gg=G :syntax on<CR>')
