set termguicolors
call plug#begin('~/.config/nvim/plugins/')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'norcalli/nvim-colorizer.lua'
Plug 'akinsho/bufferline.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'ItsTerm1n4l/spice.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'navarasu/onedark.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-autoformat/vim-autoformat'
Plug 'github/copilot.vim'
if (has("nvim"))
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
endif
Plug 'elzr/vim-json'
Plug 'numToStr/Comment.nvim'
Plug 'rmagatti/auto-session'
call plug#end()
lua require('init')

" Global Sets """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on            " Enable syntax highlight
set nu               " Enable line numbers
set tabstop=4        " Show existing tab with 4 spaces width
set softtabstop=4    " Show existing tab with 4 spaces width
set shiftwidth=4     " When indenting with '>', use 4 spaces width
set expandtab        " On pressing tab, insert 4 spaces
set smarttab         " insert tabs on the start of a line according to shiftwidth
set smartindent      " Automatically inserts one extra level of indentation in some cases
set hidden           " Hides the current buffer when a new file is openned
set incsearch        " Incremental search
set ignorecase       " Ingore case in search
set smartcase        " Consider case if there is a upper case character
set scrolloff=8      " Minimum number of lines to keep above and below the cursor
set signcolumn=yes   " Add a column on the left. Useful for linting
set cmdheight=2      " Give more space for displaying messages
set updatetime=100   " Time in miliseconds to consider the changes
set encoding=UTF-8   " The encoding should be utf-8 to activate the font icons
set nobackup         " No backup files
set nowritebackup    " No backup files
set splitright       " Create the vertical splits to the right
set splitbelow       " Create the horizontal splits below
set autoread         " Update vim after file update from outside
set mouse=a          " Enable mouse support
set background=dark
filetype on          " Detect and set the filetype option and trigger the FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any

set foldmethod=indent
" set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
set cursorline

" Airline
set noshowmode
set laststatus=2
" Highlight na linha do cursor
set cul

if has("unnamedplus")
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Set colorscheme
" colorscheme spice
let g:onedark_config = {
            \ 'style': 'warmer',
            \ 'toggle_style_key': '<leader>ts',
            \ 'ending_tildes': v:true,
            \ 'diagnostics': {
            \ 'darker': v:true,
            \ 'background': v:false,
            \ },
            \ }
colorscheme onedark

" Start NvimTreeFocus when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NvimTreeFocus | endif

" Remove
autocmd BufWritePre * :%s/\s\+$//e

" Keybinds
map     <F8> <esc>:q<enter><Right>
map     <F4> <esc>:bd<enter><Right>
map     <F9> <esc>:NvimTreeClose<esc>:SessionSave<esc>:qa<enter><Right>
nmap    <F21> <esc>:NvimTreeClose<esc>:SessionRestore<enter><Right>
imap    <C-s> <esc>:w<enter><Right>
map     <C-s> <esc>:w<enter><Right>
imap    <C-z> <esc>:undo<enter>i<Right>
map     <C-z> <esc>:undo<enter><Right>
imap    <C-\> <esc>:redo<enter>i<Right>
map     <C-\> <esc>:redo<enter>i<Right>
nmap    <F2> <esc>:NvimTreeToggle<enter><CR>
nmap    <C-l> <esc>:NvimTreeFindFile<enter><CR>
noremap <C-i> :Autoformat<CR>
noremap <C-j> :%!jq .<CR>

nnoremap ; :
vnoremap ; :

" Shortcuts for split navigation
map     <C-S-Left> <C-w>h
map     <C-S-Right> <C-w>l
map     <C-S-Down> <C-w>j
map     <C-S-Up> <C-w>k
map     <C-[> <esc>:NvimTreeCollapse<CR>

" Navigate between buffers
nmap    <A-Right> :bn<CR>
nmap    <A-Left> :bp<CR>

" Create splits
nmap    <C-h> :split<CR>
nmap    <C-v> :vsplit<CR>
nmap    <C-b> <esc>:new<enter><Right>
map    <C-t> <esc>:tabnew<enter><Right>

" Shortcuts for copy/cut - necessary xclip pacakge in Linux
vmap    <C-c> "+y
vmap    <C-x> "+d

" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

set nowrap

function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NvimTreeOpen | endif

" AirLine """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Autosession
let g:auto_session_root_dir = get(g:, 'auto_session_root_dir', '~/.config/nvim/sessions')

