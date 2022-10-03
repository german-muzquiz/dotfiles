"----------------------------------------------------------------------------------------------------
"--------------------------------------------- Initial setup ----------------------------------------
"----------------------------------------------------------------------------------------------------
"Install plugins                        :PlugInstall
"Install ripgrep for find in files      https://github.com/BurntSushi/ripgrep#installation
"Install python language server         pip install "python-lsp-server[all]"
"Install terraform language server      https://github.com/hashicorp/terraform-ls
"Install yaml language server           yarn global add yaml-language-server



"-------------------------------------------- Starting settings -------------------------------------

set t_Co=256            "Terminal color support
filetype plugin on      "Different settings for different file types, living in ~/.vim/after/ftplugin/{filetype}.vim



"------------------------------------------------ Plugins -------------------------------------------
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

Plug 'tanvirtin/monokai.nvim' 		                "Color scheme
Plug 'preservim/nerdtree'                           "File explorer
Plug 'mhinz/vim-signify'                            "Margin style for vcs modified files
Plug 'tpope/vim-fugitive'                           "Git goodies
Plug 'vim-airline/vim-airline'                      "Status line
Plug 'vim-airline/vim-airline-themes'               "Status line themes
Plug 'andrewstuart/vim-kubernetes'                  "Kube commands
Plug 'hashivim/vim-terraform'                       "Terraform file types
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "Fuzzy file finder
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/AutoComplPop'                     "Automatically show vim's complete menu while typing
Plug 'neovim/nvim-lspconfig'                        "Native neovim language server protocol


" Initialize plugin system
call plug#end()

" Load config from ~/.config/nvim/lua/config.lua
lua require('config')

"------------------------------------------------ Colors -------------------------------------------
set background=dark
colorscheme monokai_ristretto
let g:airline_theme='deus'


"------------------------------------------------ Common -------------------------------------------
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
endif
set encoding=utf-8
set nobreakindent   	"Don't break lines automatically
set tw=0                "Don't break lines automatically
set nowrap
set sidescroll=1
set sidescrolloff=50
set showmode
set showcmd             "Display incomplete commands
set hidden
" Show autocomplete options
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/node_modules/*,*/target/*,*/*.jar,*/*.class,*/*.zip,*/*.tar,*/*.gz,*/*.war,*/bower_components/*,*/dist/*,*/.terraform/*
set completeopt=longest,preview,menuone
set cursorline
set ruler               "Show the cursor position all the time
set number
" Search settings
set hlsearch
set incsearch           "Do incremental searching
set smartcase
set laststatus=2        "Always display the status line
set ignorecase
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
set so=999
set nobackup            "Coc vim: Some language servers have issues with backup files
set nowritebackup       "Coc vim: Some language servers have issues with backup files
set directory=~/.config/nvim/swap//
set autowriteall        "Write all changes when leaving buffer
set path+=**
set updatetime=100      "Default updatetime 4000ms is not good for async update. This setting is lowered for signify and coc
" Default tab handling
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
set diffopt+=vertical   "Always use vertical diffs

"------------------------------------------------ Custom keybindings -------------------------------------------
let mapleader="\<Space>"
" Cycle through splits
nnoremap <TAB> <C-w>w
" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>
" Hide search highlights
nnoremap <leader>, :noh<CR>
" Select all
nnoremap <Leader>a <esc>ggVG<CR>
" Format all
nnoremap <Leader>l :syntax off<CR> gg=G :syntax on<CR>
" Go back to previous buffer
nnoremap <Leader>6 :b#<CR>
" Fuzzy find files
nnoremap ff :Files<CR>
" Fuzzy find buffers
nnoremap fb :Buffers<CR>
" Find in files
"nnoremap <Leader>f :vimgrep //j **<left><left><left><left><left>
nnoremap fs :Rg! 
nnoremap l[ :lprevious<CR>
nnoremap l] :lnext<CR>
" Load commit history of current file
"nnoremap <Leader>h :Gclog! -- %<CR>
nnoremap <Leader>h :BCommits!<CR>
" Show git status
nnoremap <Leader>g :Git<CR>
" Commit
nnoremap <Leader>k :Git commit<CR>
" Push
nnoremap <Leader>p :Git push<CR>
" Navigate the complete menu items like CTRL+n / CTRL+p would
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <TAB> pumvisible() ? "<C-n>" :"<TAB>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" :"<Up>"
inoremap <expr> <S-TAB> pumvisible() ? "<C-p>" :"<S-TAB>"
" Select the complete menu item like CTRL+y would
inoremap <expr> <Right> pumvisible() ? "<C-y>" :"<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" :"<CR>"
" Cancel the complete manu item like CTRL+e would
inoremap <expr> <Left> pumvisible() ? "<C-e>" :"<Left>"



" Remember last position in file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Automatically open quick fix window or location window after vimgrep and
" friends
augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END


"----------------------------------------------------------------------------------------------------
"--------------------------------------------- Plugin config ----------------------------------------
"----------------------------------------------------------------------------------------------------

" -------------------------------- NERDTree -------------------------------
" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

let NERDTreeWinSize=45
nnoremap <Leader>1 :NERDTreeToggle<CR>
nnoremap <Leader>2 :NERDTreeFind<CR>

" -------------------------------- Signify --------------------------------
let g:signify_realtime = 1


" ---------------------------------- FZF ----------------------------------
" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }


" ------------------------------ My custom help -----------------------------

function! MyCustomHelp() 
    :setlocal modifiable
    :e myhelp
    call appendbufline("myhelp", "^", "-------------------------------------------------")
    call appendbufline("myhelp", "^", "Main keybindings")
    call appendbufline("myhelp", "^", "-------------------------------------------------")
    call appendbufline("myhelp", "$", "")
    call appendbufline("myhelp", "$", "-> Normal mode, custom")
    call appendbufline("myhelp", "$", "")
    call appendbufline("myhelp", "$", "<TAB>                Cycle through splits")
    call appendbufline("myhelp", "$", "<Space>,             Hide highlights")
    call appendbufline("myhelp", "$", "<Space>a             Select all")
    call appendbufline("myhelp", "$", "<Space>6             Go back to previous buffer")
    call appendbufline("myhelp", "$", "ff                   Fuzzy find files")
    call appendbufline("myhelp", "$", "fb                   Fuzzy find buffers")
    call appendbufline("myhelp", "$", "fs                   Find string in files (like grep)")
    call appendbufline("myhelp", "$", "<Space>h             Git commit history")
    call appendbufline("myhelp", "$", "<Space>g             Git status")
    call appendbufline("myhelp", "$", "<Space>k             Git commit")
    call appendbufline("myhelp", "$", "<Space>p             Git push")
    call appendbufline("myhelp", "$", "gd                   Go to definition")
    call appendbufline("myhelp", "$", "gD                   Go to declaration")
    call appendbufline("myhelp", "$", "gi                   Go to implementation")
    call appendbufline("myhelp", "$", "gr                   Go to references")
    call appendbufline("myhelp", "$", "gk                   Doc for symbol under cursor (LSP source)")
    call appendbufline("myhelp", "$", "")
    call appendbufline("myhelp", "$", "-> Normal mode, vim standard")
    call appendbufline("myhelp", "$", "K                    Show documentation (keywordprg source)")
    call appendbufline("myhelp", "$", "")
    call appendbufline("myhelp", "$", "-> Insert mode, vim standard")
    call appendbufline("myhelp", "$", "<CTRL+x><CTRL+o>     Autocomplete from LSP, tags file, etc.")
    :setlocal nomodifiable
    :setlocal buftype=nofile
    :setlocal bufhidden=wipe
    :setlocal filetype=myhelp
endfunction

command! -nargs=0 MyHelp call MyCustomHelp()
nnoremap ? :MyHelp<CR>


