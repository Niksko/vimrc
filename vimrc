" .vimrc
" Nikolas M. Skoufis, 11/9/15
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage plugins
Plugin 'VundleVim/Vundle.vim'
" Badwolf colorscheme
Plugin 'sjl/badwolf'
" YouCompleteMe intelligent autocomplete
Plugin 'Valloric/YouCompleteMe'
" Intelligent autocomplete for delimiters
Plugin 'Raimondi/delimitMate'
" Auto closing of xml tags
Plugin 'alvan/vim-closetag'
" Syntax analysis, linting etc
Plugin 'scrooloose/syntastic'
" Pretty lower status bar
Plugin 'bling/vim-airline'
" Shortcut for commenting out lines
Plugin 'tpope/vim-commentary'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Set the colorscheme
colorscheme badwolf
" Enable syntax highlighting
syntax enable

" Set the number of spaces per tab when editing
set softtabstop=4
" Set the amount of space per shift using <<, >> etc.
set shiftwidth=4
" Set tabs to spaces
set expandtab

" Allow for using all colors
set t_Co=256

" Show the line number
set number
" Show the last command in the bottom right
set showcmd
" Underline the current line
set cursorline
" Load filetype specific indent files
filetype indent on

" Highlight columns 80 and 120 for adhering to line length limits
set colorcolumn=80,120

" Turn on visual autocomplete for the command menu
set wildmenu
" Redraw only when needed'
set lazyredraw
" Show matching parentheses
set showmatch

" Search as characters are enetered
set incsearch
" Highlight search matches
set hlsearch

" Enable folding
set foldenable
" Show all folds
set foldlevelstart=10
" Max fold nesting
set foldnestmax=10
" Fold based on indents
set foldmethod=indent

" Turn on closetag plugin support for specified filetypes
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.xsd,*.xslt"

" Some sensible defaults for syntastic syntax checking plugin
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Get syntastic to use pep8, then pylint for checking
let g:syntastic_python_checkers = ['flake8', 'pylint']
" Let syntastic show the errors from all checkers at once
let g:syntastic_aggregate_errors = 1

" Pass some command line arguments to our checkers
" For flake8, we want to have a max line length of 120 (to stop nagging)
" We also want to warn about a max cyclomatic complexity of 10
let g:syntastic_python_flake8_args = "--max-line-length=120 --max-complexity=10"

" And we also want to make pylint forget about line too long, since flake7
" already checks that for us
let g:syntastic_python_pylint_post_args= "--disable=line-too-long"

" Get airline to showup without making a split
set laststatus=2

" Add spellcheck support
set spell
set spellsuggest=best,10

" Move vertically based on visual line, not actual line
nnoremap j gj
nnoremap k gk

" Language specific settings
augroup configgroup
    " Apparently required to auto execute commands
    autocmd!
    " Indent xml type files with 2 spaces
    autocmd FileType xml,xsd,xslt setlocal shiftwidth=2
    autocmd FileType xml,xsd,xslt setlocal softtabstop=2
augroup END

