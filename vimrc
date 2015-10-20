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
" Git integration
Plugin 'tpope/vim-fugitive'
" CtrlP fuzzy file search
Plugin 'kien/ctrlp.vim'

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

" Set the pythonpath correctly
let $PYTHONPATH='/usr/lib/python3.5/site-packages'

" Git integration with statusline/airplane
set statusline+=%{fugitive#statusline()}

" Some sensible defaults for syntastic syntax checking plugin
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Get syntastic to use flake8 for checking
let g:syntastic_python_checkers = ['flake8']

" Pass some command line arguments to our checkers
" For flake8, we want to have a max line length of 120 (to stop nagging)
" We also want to warn about a max cyclomatic complexity of 10
let g:syntastic_python_flake8_args = "--max-line-length=120 --max-complexity=10"

" Get airline to showup without making a split
set laststatus=2

" Let airline auto populate powerline symbols
let g:airline_powerline_fonts = 1

" Add spellcheck support
set spell
set spellsuggest=best,10

" Allow for switching buffers without saving
set hidden

" Settings for CtrlP plugin
" Set default mapping and default command for opening ctrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Set default working directory
let g:ctrlp_working_path_mode = 'ra'
" Exclude some files from search
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Custom file listing command
let g:ctrlp_user_command = 'find %s -type f'

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
    " Indent arduino type files with 2 spaces
    autocmd FileType arduino setlocal shiftwidth=2
    autocmd FileType arduino setlocal softtabstop=2
    " Indent javascript type files with 2 spaces
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType javascript setlocal softtabstop=2
augroup END

