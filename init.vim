call plug#begin('~/.local/share/nvim/plugged')

" Colorscheme
Plug 'romainl/apprentice'

" Linting
Plug 'w0rp/ale'

" Filetree
Plug 'scrooloose/nerdtree' 
Plug 'Xuyuanp/nerdtree-git-plugin'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'

" Git
Plug 'tpope/vim-fugitive'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Auto complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'

" Typescript 
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'build': './install.sh'}

" Golang
" go get -u github.com/stamblerre/gocode
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Javascript
Plug 'wokalski/autocomplete-flow'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Python
Plug 'deoplete-plugins/deoplete-jedi'
" create virtual environments for neovim package for python
" let g:python_host_prog = '/full/path/to/neovim2/bin/python'
" let g:python3_host_prog = '/full/path/to/neovim3/bin/python'

" Utilities
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'craigemery/vim-autotag'
Plug 'majutsushi/tagbar'

" Markdown tools
Plug 'mzlogin/vim-markdown-toc'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
call plug#end()

let g:mdtoc_starting_header_level = 2

nmap <F2> :TagbarToggle<CR>

let mapleader = ","

" Remap split pane navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Colorscheme
colorscheme apprentice
let g:airline_theme='base16'

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" highlight cursor line
set cursorline

" auto read and write
set autowrite
" when deal with unsaved files ask what to do
set confirm

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4

set backspace=2 " make backspace work like most other apps

" when scrolling, keep cursor 4 lines away from screen border
set scrolloff=4

" Use relative line numbers
if exists("&relativenumber")
    set relativenumber
    set number
    au BufReadPost * set relativenumber
endif

" tab navigation mappings
map <leader>tn :tabn<CR>
map <leader>tp :tabp<CR>
map <leader>tm :tabm 
map <leader>tt :tabnew <CR>
map <leader>ts :tab split<CR>
map <C-S-Right> :tabn<CR>

" muting search highlighting 
nnoremap <silent> ,l :<C-u>nohlsearch<CR><C-l>

" simple recursive grep
" both recursive grep commands with internal or external (fast) grep
command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
" mappings to call them
nmap ,R :RecurGrep 
nmap ,r :RecurGrepFast 

" mappings to call them with the default word as search text
nmap ,wR :RecurGrep <cword><CR>
nmap ,wr :RecurGrepFast <cword><CR>

"
" deoplete 
"
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1

" Deoplete remap of arrow keys 
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"


autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd FileType gitcommit setlocal spell
set complete+=kspell

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2

"
"" NERDTree --------------------------------
"
"" auto open or close NERDTree
autocmd vimenter * if !argc() | NERDTree | endif

"" toggle NERDTree Display
map <C-n> : NERDTreeToggle<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

"" Python
"
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix

"" ALE linting ---------------------------
"
let g:ale_linters_explicit = 1
let g:ale_linters = {'javascript':['eslint'], 'go':['gofmt'], 'python':['pylint']}
let g:ale_fixers = {'javascript':['prettier_eslint'], 'python':['autopep8'], 'go':['gofmt']}
let g:ale_lint_delay = 1000
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
