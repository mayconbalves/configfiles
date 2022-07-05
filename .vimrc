set shell=/bin/sh
set tabstop=2
set shiftwidth=2
set textwidth=80
set colorcolumn=+1
set expandtab

let g:vim_jsx_pretty_colorful_config = 1
let NERDTreeShowHidden=1

let g:user_emmet_install_global = 1
autocmd FileType html,css EmmetInstall

let g:user_emmet_leader_key='<C-Z>'

" Leader key
let mapleader = " "
let g:jsx_ext_required = 0

" set nocompatible
filetype on
set backspace=indent,eol,start

set rtp+=~/.vim/bundle/Vundle.vim
filetype plugin indent on

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

let g:coc_global_extensions = [
	\ 'coc-tsserver'
  \]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
	let g:coc_global_extensions += ['coc-eslint']
endif

nnoremap <silent> K :call CocAction('doHover')<CR>

function! ShowDocIfNoDiagnostic(timer_id)
   if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
     silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)

call plug#begin('~/.vim/plugged')
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main'  }
Plug 'jparise/vim-graphql'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'gabesoft/vim-ags'

" prettier "
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" ts and graphql "
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" react
Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'justinj/vim-react-snippets'
Plug 'bentayloruk/vim-react-es6-snippets'

" Colors
Plug 'crusoexia/vim-monokai'
Plug 'joshdick/onedark.vim'
Plug 'liuchengxu/space-vim-dark'

" Manages indentation
Plug 'tpope/vim-sleuth'
Plug 'yggdroot/indentline'

" Airline
Plug 'bling/vim-airline'
set laststatus=2

" Gists plugin
Plug 'mattn/webapi-vim' " Dependency
Plug 'mattn/gist-vim'
let g:gist_show_privates = 1
let g:gist_post_private = 1

" Alignhment
Plug 'junegunn/vim-easy-align'
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Dependencies for the gem below
Plug 'tmhedberg/matchit'
Plug 'kana/vim-textobj-user'

" Run rspec
" Run tests
Plug 'janko-m/vim-test'
nmap <silent> <leader>tt :TestFile<CR>
nmap <silent> <leader>ts :TestNearest<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" Tagbar
Plug 'majutsushi/tagbar'
nmap <leader>tb :TagbarToggle<CR>

" This plugin is needed to enable repeat `.` in plugins like surround
" also from tpope
Plug 'tpope/vim-repeat'

" " General plugins
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-bundler'
Plug 'editorconfig/editorconfig-vim'
Plug 'kien/ctrlp.vim'
Plug 'Valloric/MatchTagAlways'
Plug 'rking/ag.vim'
Plug 'danro/rename.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'isruslan/vim-es6'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/yajs.vim'
Plug 'maxmellon/vim-jsx-pretty'

" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque'


" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'

" Wakatime
Plug 'wakatime/vim-wakatime'

call plug#end()

" Colorscheme
syntax on
colors space-vim-dark
set t_Co=256

" Preferences
set visualbell    " don't beep
set noerrorbells  " don't beep
set autoread " Auto read when a file is changed on disk"
set autoindent
set copyindent
set number " line numbers
set showmode " always show mode
set cursorline " highlight current line
set history=100
set undolevels=10000  " Use more levels of undo"

" dont use backup files
set nobackup
set noswapfile
" set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp   " store swap files
" here

" Search things
set incsearch   " show search matches as you type
set ignorecase  " case insensitive search
set smartcase   " If a capital letter is included in search, make it

" case-sensitive
set nohlsearch  " dont highlight search results
set timeoutlen=1000 ttimeoutlen=0 " Remove 'esc' delay
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Start search
noremap <leader>r :%s/

" Paste mode
nnoremap <leader>o :set invpaste<CR>

" Tired of :w :q etc
nnoremap ;w :w<CR>
nnoremap ;q :q<CR>
nnoremap ;wq :wq<CR>
nnoremap ;qa :qa<CR>

" Selecting last pasted or changed text
nnoremap <expr> <leader>gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Open splits on right and below
set splitbelow
set splitright

" Open ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
noremap <leader>p :CtrlP<CR>
noremap <leader>. :CtrlPTag<CR>
noremap <leader>b :CtrlPBuffer<CR>
noremap <leader>m :CtrlPMRU<CR>

" Ctrlp ignore file list
let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|target|dist)|(\.(swp|ico|git|svn))$'

" allow saving a sudo file if forgot to open as sudo
cmap w!! w !sudo tee % >/dev/null

" Golang highlighting
" " Some Linux distributions  filetype in /etc/vimrc.
" " " Clear filetype flags before changing runtimepath to force Vim to reload
" " them.
" filetype on
" filetype plugin indent on
" set runtimepath+=/usr/local/go/misc/vim
"
" " use goimports after save"
" " let g:go_fmt_command = "goimports"
"
" " Relative numbers
" set relativenumber " use relative numbers
" autocmd InsertEnter * silent! : norelativenumber
" autocmd InsertLeave,BufNewFile,VimEnter * silent! : relativenumber
"
" JS beautify
autocmd FileType javascript vnoremap <buffer>  <c-f> :call
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>
"
" " Disable arrow keys"
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" " Tmux fix color backgrounds
" "
" http://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux
" set t_ut=
"
" Split navigation with something fancy :)
map <silent> <leader>h :call WinMove('h')<cr>
map <silent> <leader>j :call WinMove('j')<cr>
map <silent> <leader>k :call WinMove('k')<cr>
map <silent> <leader>l :call WinMove('l')<cr>

" " Window movement shortcuts
" " move to the window in the direction shown, or create a new window
function! WinMove(key)
	let t:curwin = winnr()
	exec "wincmd ".a:key
	if (t:curwin == winnr())
		if (match(a:key,'[jk]'))
			wincmd v
		else
			wincmd s
		endif
		exec "wincmd ".a:key
	endif
endfunction

" Add javascript syntax to es6, es7 files
autocmd BufNewFile,BufRead *.es6   set syntax=javascript
autocmd BufNewFile,BufRead *.es7   set syntax=javascript

" Add html syntax to ejs
autocmd BufNewFile,BufRead *.ejs set syntax=html

" Add spell checking and wrap at 72 columns git commit message
autocmd Filetype gitcommit setlocal spell textwidth=72

" Run buffer in postgres as a query
map <leader>rq :w !psql -d PremiosOnline_development -f -<cr>

" Change buffers
map ,, :bnext<cr>
map ,. :bprevious<cr>

command! Vb normal! <C-v>
