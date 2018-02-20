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
Plugin 'ctrlpvim/ctrlp.vim'
" Urbit Hoon syntax and other goodies
Plugin 'urbit/hoon.vim'
" Plugins for jsx support in vim and proper hilighting
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'

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
" Fix colors under tmux as per advice at https://askubuntu.com/a/557620
set term=screen-256color

" Show the line number
set number
" Show the last command in the bottom right
set showcmd
" Highlight the current line
set cursorline
" Highlight the current column
set cursorcolumn
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
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.xsd,*.xslt,*.xsl"

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

" Aggregate errors. That is, show all errors from all checkers simultaneously
" The default behaviour is to stop if no errors are found
let g:syntastic_aggregate_errors = 1

" Get syntastic to use flake8 for checking and mypy for type checking
let g:syntastic_python_checkers = ['mypy', 'flake8']

" Pass some command line arguments to our checkers
" For flake8, we want to have a max line length of 120 (to stop nagging)
" We also want to warn about a max cyclomatic complexity of 10
let g:syntastic_python_flake8_args = "--max-line-length=120 --max-complexity=10"

" Enable eslint checking for javascript files
let g:syntastic_javascript_checkers = ['eslint']

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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*,*/node_modules/*

" Custom file listing command
let g:ctrlp_user_command = 'find %s -type f'

" Move vertically based on visual line, not actual line
nnoremap j gj
nnoremap k gk

" Map renaming to F2, ala resharper
nnoremap <F2> :YcmCompleter RefactorRename

" delimitMate stuff
" Allows the nesting of quotes for Python docstrings
let delimitMate_nesting_quotes = ['"','`']
" Jumps over expansions
let delimitMate_jump_expansion = 1

" Language specific settings
augroup configgroup
    " Apparently required to auto execute commands
    autocmd!
    " Indent xml type files with 2 spaces
    autocmd FileType xml,xsd,xslt,html,css setlocal shiftwidth=2
    autocmd FileType xml,xsd,xslt,html,css setlocal softtabstop=2
    " Indent arduino type files with 2 spaces
    autocmd FileType arduino setlocal shiftwidth=2
    autocmd FileType arduino setlocal softtabstop=2
    " Indent javascript type files with 2 spaces
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType javascript setlocal softtabstop=2
    " Indent yaml type files with 2 spaces
    autocmd FileType yaml setlocal shiftwidth=2
    autocmd FileType yaml setlocal softtabstop=2
    " python doc strings require this
    autocmd FileType python let b:delimitMate_expand_inside_quotes = 1
    autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

