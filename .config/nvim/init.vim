
" Terminal color support
set t_Co=256

" ======================================== PLUGINS =======================================
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

Plug 'tanvirtin/monokai.nvim' 		    "Color scheme
Plug 'preservim/nerdtree'               "File explorer
Plug 'mhinz/vim-signify'                "Margin style for vcs modified files
Plug 'tpope/vim-fugitive'               "Git goodies
Plug 'vim-airline/vim-airline'          "Status line
Plug 'vim-airline/vim-airline-themes'   "Status line themes
Plug 'vim-syntastic/syntastic'          "Syntax checking

" Initialize plugin system
call plug#end()

" ===================================== END PLUGINS ======================================



" ======================================= BASIC ==========================================
syntax on
set encoding=utf-8
set nobreakindent   	"Don't break lines automatically
set nowrap
set sidescroll=1
set sidescrolloff=50
set showmode
set showcmd
set hidden
" Show autocomplete options
set wildmenu
set completeopt=longest,preview,menuone
set cursorline
set ttyfast
set ruler
"set relativenumber
set number
" Highlight search matches
set hlsearch
set incsearch
set smartcase
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/node_modules/*,*/target/*,*/*.jar,*/*.class,*/*.zip,*/*.tar,*/*.gz,*/*.war,*/bower_components/*,*/dist/*
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
set pastetoggle=<F3>
set so=999
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
" Write all changes when leaving buffer
set autowriteall
set path+=**
set tags=./tags;
"set synmaxcol=120
set background=dark

colorscheme monokai
let g:airline_theme='deus'

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Tab 4
au FileType python,java
    \ setlocal tabstop=4
    \| setlocal softtabstop=4
    \| setlocal shiftwidth=4
    \| setlocal textwidth=79
    \| setlocal expandtab
    \| setlocal autoindent
    \| setlocal fileformat=unix

" Tab 2
au FileType html,css,js
    \ setlocal tabstop=2
    \| setlocal shiftwidth=2
    \| setlocal expandtab
    \| setlocal autoindent


" Highlight bad whitespaces
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let python_highlight_all=1


" Custom bindings
let mapleader="\<Space>"
" Hide search highlights
nnoremap <leader>, :noh<CR>
" Select all
nnoremap <Leader>a <esc>ggVG<CR>
"" Format all
nnoremap <Leader>l :syntax off<CR> gg=G :syntax on<CR>
"" Go back to previous buffer
nnoremap <Leader>6 :b#<CR>

"" au FileType xml nnoremap <Leader>l :%s/&lt;/</g<CR> :%s/&gt;/>/g<CR> :%s/></>\r</g<CR> :syntax off<CR> gg=G :syntax on<CR>
au FileType xml nnoremap <Leader>l :%s/></>\r</g<CR> :syntax off<CR> gg=G :syntax on<CR>
au FileType json setlocal equalprg=python\ -m\ json.tool\ 2>/dev/null


" Remember last position in file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" NERDTree configuration
let NERDTreeWinSize=45
nnoremap <F1> :NERDTreeToggle<CR>
nnoremap <F2> :NERDTreeFind<CR>

" default updatetime 4000ms is not good for async update
set updatetime=100
let g:signify_realtime = 1

" ========================== Syntastic ========================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']

