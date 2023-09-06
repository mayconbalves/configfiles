call plug#begin('~/.vim/plugged')
" Colors
Plug 'liuchengxu/space-vim-dark'

" Airline
Plug 'bling/vim-airline'

" Tagbar
Plug 'majutsushi/tagbar'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" General plugins
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'rking/ag.vim'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" CocVim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntastic
Plug 'vim-syntastic/syntastic'

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Wakatime
Plug 'wakatime/vim-wakatime'

call plug#end()

" Colorscheme
syntax on
colors space-vim-dark
set t_Co=256
set laststatus=2
set updatetime=300
set shell=/bin/sh
set tabstop=2
set shiftwidth=2
set textwidth=80
set history=100
set cursorline

" Search things
set incsearch   " show search matches as you type
set ignorecase  " case insensitive search
set smartcase

" Start search
noremap <leader>r :%s/

" Paste mode
nnoremap <leader>o :set invpaste<CR>

" Tired of :w :q etc
nnoremap ;w :w<CR>
nnoremap ;q :q<CR>
nnoremap ;wq :wq<CR>
nnoremap ;qa :qa<CR>

" Open ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
noremap <leader>p :CtrlP<CR>
noremap <leader>. :CtrlPTag<CR>
noremap <leader>b :CtrlPBuffer<CR>
noremap <leader>m :CtrlPMRU<CR>

" Ctrlp ignore file list
let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|target|dist)|(\.(swp|ico|git|svn))$'

if executable('rg')
	  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
endif

" Syntastic alias
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" ==========
