"--------------------------------------------- Initial setup ----------------------------------------
":PlugInstall           Install plugins
"Install nodejs
":CocInstall coc-yaml   Install language server autocompletion for yaml
":CocInstall coc-json   Install language server autocompletion for json



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

Plug 'tanvirtin/monokai.nvim' 		            "Color scheme
Plug 'preservim/nerdtree'                       "File explorer
Plug 'mhinz/vim-signify'                        "Margin style for vcs modified files
Plug 'tpope/vim-fugitive'                       "Git goodies
Plug 'vim-airline/vim-airline'                  "Status line
Plug 'vim-airline/vim-airline-themes'           "Status line themes
Plug 'vim-syntastic/syntastic'                  "Syntax checking
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Language server client, used for autocompletion. :CocConfig
Plug 'andrewstuart/vim-kubernetes'              "Kube commands

" Initialize plugin system
call plug#end()



"------------------------------------------------ Colors -------------------------------------------
set background=dark
colorscheme monokai
let g:airline_theme='deus'


"------------------------------------------------ Common -------------------------------------------
syntax on
set encoding=utf-8
set nobreakindent   	"Don't break lines automatically
set tw=0                "Don't break lines automatically
set nowrap
set sidescroll=1
set sidescrolloff=50
set showmode
set showcmd
set hidden
" Show autocomplete options
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/node_modules/*,*/target/*,*/*.jar,*/*.class,*/*.zip,*/*.tar,*/*.gz,*/*.war,*/bower_components/*,*/dist/*
set completeopt=longest,preview,menuone
set cursorline
set ruler
set number
" Search settings
set hlsearch
set incsearch
set smartcase
set ignorecase
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
set so=999
set backupdir=~/.config/nvim/backup//
set directory=~~/.config/nvim/swap//
set autowriteall " Write all changes when leaving buffer
set path+=**
" Default tab handling
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"------------------------------------------------ Custom keybindings -------------------------------------------
let mapleader="\<Space>"
" Hide search highlights
nnoremap <leader>, :noh<CR>
" Select all
nnoremap <Leader>a <esc>ggVG<CR>
"" Format all
nnoremap <Leader>l :syntax off<CR> gg=G :syntax on<CR>
"" Go back to previous buffer
nnoremap <Leader>6 :b#<CR>

" Remember last position in file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"------------------------------------------------ Plugin config -----------------------------------------------
" NERDTree
let NERDTreeWinSize=45
nnoremap <F1> :NERDTreeToggle<CR>
nnoremap <F2> :NERDTreeFind<CR>

" Signify
set updatetime=100          "Default updatetime 4000ms is not good for async update
let g:signify_realtime = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" ----------- Plugin coc ----------
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

