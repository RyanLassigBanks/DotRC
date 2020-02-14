set number
set encoding=utf-8
set tags+=tags
set tags+=.tags
set hlsearch
set cursorline
set cursorline
set backspace=indent,eol,start
set mouse=a
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

"tab characters now render as dots
set list
set listchars=tab:..

"enable soft tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"change tabsize when working with different file types
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype yml setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype proto setlocal ts=2 sw=2 sts=0 expandtab

"Link Cut, Copy, and Paste to Clipboard
set clipboard+=unnamed
set clipboard+=unnamedplus

"Plugins

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'dracula/vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'terryma/vim-smooth-scroll'
Plug 'pangloss/vim-javascript'
Plug 'Townk/vim-autoclose'
Plug 'mxw/vim-jsx'
Plug 'uarun/vim-protobuf'
Plug 'cespare/vim-toml'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'

call plug#end()

"Configure color scheme

syntax on
colorscheme dracula

"Netrw

let g:netrw_banner = 0

"NerdTree

"autocmd vimenter * NERDTree
map - :NERDTreeToggle<CR>

"Light line

set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'deus',
  \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'FilenameForLightline'
  \ },
  \}

function! FilenameForLightline()
    return expand('%')
endfunction

"ripgrep with FZF

 "--column: Show column number
  " --line-number: Show line number
  " --no-heading: Do not show file headings in results
  " --fixed-strings: Search term as a literal string
  " --ignore-case: Case insensitive search
  " --no-ignore: Do not respect .gitignore, etc...
  " --hidden: Search hidden files and folders
  " --follow: Follow symlinks
  " --glob: Additional conditions for search (in this case ignore everything
  "in the .git/ folder)
  " --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep("rg --column --line-number  --no-heading --fixed-strings --ignore-case --follow --glob '!.git/*' --color 'always' ".shellescape(<q-args>), 1, <bang>0)

"terryma/vim-smooth-scroll

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

"w0rp/ale

let g:ale_lint_on_text_changed='always'
let g:ale_linters = {'rust': ['cargo']}
let g:ale_rust_cargo_use_check=1

"rust-lang/rust

let g:rustfmt_options = "--edition 2018"

"vim-jsx
"
let g:jsx_ext_required = 0

"vim-javascript

let g:javascript_plugin_flow = 1

"Mappings

map c<leader> :call NERDComment(0, "toggle")<C-m>
map <Tab> :wincmd w<C-m>
map <Space> :w!<C-m>
map & :nohlsearch<C-m>
map <leader>f :Files<C-m>
map rg :Find<Space>
map <leader>v :vsp<C-m><Tab>
map <leader>s :sp<C-m><Tab>
map r :windo e<C-m>
inoremap jj <ESC>

"Highlight line when character length is over limit
"
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%101v', 100)
