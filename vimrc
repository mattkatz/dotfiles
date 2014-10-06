" ----------------------------------------------------------------------------
"   .vimrc                                                                {{{
" ----------------------------------------------------------------------------

" }}}-------------------------------------------------------------------------
"   Vundle                                                                {{{
" ----------------------------------------------------------------------------

set nocompatible " This must be first, because it changes other options

source $HOME/.vim/plug.vim

" }}}-------------------------------------------------------------------------
"   Base Options                                                          {{{
" ----------------------------------------------------------------------------

" Set the leader key to , instead of \ because it's easier to reach
let mapleader = " "
"set notimeout                  " Turn off the timeout for the leader key
                                " Seems to break `n` in normal mode, so
                                " I turned it off
set encoding=utf-8              " I generally want utf-8 encoding
set spell                       " Turn on spelling
set spelllang=en_us             " Set the spelling language
                                " Set my personal spelling file
set spellfile=$HOME/.vim/spell/en.utf-8.add
set nohidden                    " Don't allow buffers to exist in the background
set ttyfast                     " Indicates a fast terminal connection
set backspace=indent,eol,start  " Allow backspaceing over autoindent, line breaks, starts of insert
set shortmess+=I                " No welcome screen
set history=200                 " Remember the last 200 :ex commands
set exrc                        " enable per-directory .vimrc files
set secure                      " disable unsafe commands in local .vimrc files

" }}}-------------------------------------------------------------------------
"   Visual                                                                {{{
" ----------------------------------------------------------------------------

" Control Area (May be superseded by vim-airline)
set showcmd                 " Show (partial) command in the last line of the screen.
set wildmenu                " Command completion
set wildmode=list:longest   " List all matches and complete till longest common string
set laststatus=2            " The last window will have a status line always
set noshowmode              " Don't show the mode in the last line of the screen, vim-airline takes care of it
set ruler                   " Show the line and column number of the cursor position, separated by a comma.
set lazyredraw
set linespace=0

" My command line autocomplete is case insensitive. Keep vim consistent with
" that. It's a recent feature to vim, test to make sure it's supported first.
if exists("&wildignorecase")
    set wildignorecase
endif

" Buffer Area Visuals
set scrolloff=7             " Minimal number of screen lines to keep above and below the cursor.
set visualbell              " Use a visual bell
set cursorline              " Highlight the current line
set number                  " Show line numbers
set wrap                    " Soft wrap at the window width
set linebreak               " Break the line on words
set textwidth=79            " Break lines at just under 80 characters
if exists('+colorcolumn')
  set colorcolumn=+1        " Highlight the column after `textwidth`
endif


" show fold column, fold by markers
set foldcolumn=0            " Don't show the folding gutter/column
set foldmethod=marker       " Fold on {{{ }}}
set foldlevelstart=20       " Open 20 levels of folding when I open a file

" Open folds under the following conditions
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo,jump
" Highlight tabs and trailing spaces
set listchars=tab:▸\ ,trail:•,eol:¬
set list

" Splits
set splitbelow              " Open new splits below
set splitright              " Open new vertical splits to the right

" Function to trim trailing white space
" Make your own mappings
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Character meaning when present in 'formatoptions'
" ------ ---------------------------------------
" c Auto-wrap comments using textwidth, inserting the current comment leader automatically.
" q Allow formatting of comments with "gq".
" r Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" t Auto-wrap text using textwidth (does not apply to comments)
" n Recognize numbered lists
" 1 Don't break line after one-letter words
" a Automatically format paragraphs
set formatoptions=cqrn1

" Colors
syntax enable               " This has to come after colorcolumn in order to draw it.
"set t_Co=256               " enable 256 colors
set background=dark
colorscheme molokai

" Use the same color for the SignColumn as the line number column
highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=236
highlight LineNr       ctermbg=233 ctermfg=236
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1

let g:airline_theme='zenburn'

" When completing, fill with the longest common string
" Auto select the first option
set completeopt=longest,menuone

" Printing options
set printoptions=header:0,duplex:long,paper:letter,syntax:n
" header:0                  Do not print a header
" duplex:long (default)     Print on both sides (when possible), bind on long
" syntax:n                  Do not use syntax highlighting.  This is faster and

" }}}-------------------------------------------------------------------------
"   GUI Specific                                                          {{{
" ----------------------------------------------------------------------------

" Consider moving these .gvim
if has("gui_running")
    " Hide Scrollbars
    set guioptions-=T       " Remove tool bar
    set guioptions-=r       " Remove right-hand scroll bar
    set guioptions-=m       " Remove menu bar
    set guioptions-=L       " Remove left-hand scroll bar

    if has("gui_gtk2")
        " Set the font for Linux machines
        let g:airline_powerline_fonts=1
        set guifont=Inconsolata\ for\ Powerline
    elseif has("gui_win32")
        " set guifont=Consolas:h11:cANSI
    else
        " set guifont=Menlo
        let g:airline_powerline_fonts=1
        set font=Inconsolata\ for\ Powerline:h13
    endif
else
    " Don't show the airline separators if we are not in GUI
    " The angle bracket defaults look fugly
    let g:airline_left_sep=' '
    let g:airline_right_sep=' '
    let g:airline_powerline_fonts=0
    set mouse+=a
    if &term =~ '^screen'
        " tmux knows the extended mouse mode
        set ttymouse=xterm2
    endif
endif

" }}}-------------------------------------------------------------------------
"   Search                                                                {{{
" ----------------------------------------------------------------------------

" Turned this off because it broke greedy search and replace
set incsearch               " Show search results as we type
set showmatch               " Show matching brackets
set hlsearch                " Highlight search results

" Use regex for searches
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
set ignorecase              " Ignore case when searching
set smartcase               " Don't ignore case if we have a capital letter

" Clear search highlights
nnoremap <leader><space> :nohlsearch<cr>

" }}}-------------------------------------------------------------------------
"   Tabs                                                                  {{{
" ----------------------------------------------------------------------------

set tabstop=4               " Show a tab as four spaces
set shiftwidth=4            " Reindent is also four spaces
set softtabstop=4           " When hit <tab> use four columns
set expandtab               " Create spaces when I type <tab>
set shiftround              " Round indent to multiple of 'shiftwidth'.
filetype plugin indent on   " Rely on file plugins to handle indenting

" }}}-------------------------------------------------------------------------
"   Custom commands                                                       {{{
" ----------------------------------------------------------------------------

" Edit the vimrc file
nmap <silent> <Leader>ev :vsp $MYVIMRC<CR>
nmap <silent> <Leader>ez :vsp $HOME/.zshrc<CR>
nmap <silent> <Leader>em :vsp $HOME/.mutt/muttrc<CR>
nmap <silent> <Leader>ep :vsp $HOME/.vim/plug.vim<CR>
nmap <silent> <Leader>es :vsp $HOME/.ssh/config<CR>
nmap <silent> <Leader>et :vsp $HOME/.tmux.conf<CR>
nmap <silent> <Leader>sv :so $MYVIMRC<CR>
nmap <silent> <Leader>sp :so $HOME/.vim/plug.vim<CR>

" Faster save/quite/close
nmap <silent> <Leader>w :update<CR>
nmap <silent> <Leader>q :quit<CR>
nmap <silent> <Leader>c :bd<CR>
nmap <silent> <Leader>n :cn<CR>
nmap <silent> <Leader>p :cp<CR>

" Trim trailing white space
nmap <silent> <Leader>t :call StripTrailingWhitespaces()<CR>

" Cd to the current file's directory
nnoremap <Leader>. :cd %:p:h<CR>:pwd<CR>

" Move current window to the far left using full height
nmap <silent> <Leader>h <C-w>H

" }}}-------------------------------------------------------------------------
"   Plugins                                                               {{{
" ----------------------------------------------------------------------------

" Set Ultisnip directory
let g:UltiSnipsSnippetDirectories=["ultisnips"]
" Cycle through ultisnip triggers with <tab>
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Return to last edit position when opening files, except git commit message
autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" Gist Vim
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Ctrl-P
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|sass-cache|pip_download_cache|wheel_cache)$',
    \ 'fil': '\v\.(png|jpg|jpeg|gif|DS_Store|pyc)$',
    \ 'link': '',
    \ }
let g:ctrlp_show_hidden = 1
let g:ctrlp_clear_cache_on_exit = 0
" Wait to update results (This should fix the fact that backspace is so slow)
let g:ctrlp_lazy_update = 1

" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" Syntastic
let g:syntastic_php_phpcs_args = '--standard=PSR1'

" Don't user pylint even though it's installed
let g:syntastic_python_checkers = ['python', 'pyflakes', 'pep8']
let g:syntastic_python_pep8_args="--ignore=E501,E121,E125,E126,E128,C0111"

" Undotree plugin.
nnoremap <F5> :UndotreeToggle<CR>


" }}}-------------------------------------------------------------------------
"   Custom filetypes                                                      {{{
" ----------------------------------------------------------------------------

" Auto detect filetype
autocmd BufRead,BufNewFile *.md,*.markdown  set filetype=markdown
autocmd BufRead,BufNewFile *.js             set filetype=javascript
autocmd BufRead,BufNewFile *.lytex          set filetype=tex
autocmd BufRead,BufNewFile ~/dotfiles/ssh/config set filetype=sshconfig
autocmd BufRead,BufNewFile *.git/config,.gitconfig,.gitmodules,gitconfig set ft=gitconfig
" Override what is done in /vim/bundle/scss-syntax.vim/ftdetect/scss.vim
" This should prevent duplicate snippets
autocmd BufRead,BufNewFile *.scss           set filetype=scss
autocmd BufRead,BufNewFile *.py             setlocal foldmethod=indent

"php syntax options
let php_sql_query = 1                   "for SQL syntax highlighting inside strings
let php_htmlInStrings = 1               "for HTML syntax highlighting inside strings
"php_baselib = 1                        "for highlighting baselib functions
"php_asp_tags = 1                       "for highlighting ASP-style short tags
"php_parent_error_close = 1             "for highlighting parent error ] or )
"php_parent_error_open = 1              "for skipping an php end tag, if there exists an open ( or [ without a closing one
"php_oldStyle = 1                       "for using old colorstyle
"php_noShortTags = 1                    "don't sync <? ?> as php
let php_folding = 1                     "for folding classes and functions
" Turn on completion for php
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
" Run Exuberant Ctags everytime I save a php file
autocmd BufWritePost php silent! !ctags -R &

"js syntax options
let javaScript_fold=1                   "for folding classes and functions

" Sass and Css options
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}

" HTML options
autocmd BufNewFile,BufRead *.html set filetype=htmldjango

" Per file-type indention rules
autocmd FileType html        setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType css         setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType scss        setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript  setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType config      setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType gitconfig   setlocal ts=2 sts=2 sw=2 noexpandtab
autocmd FileType ruby,eruby  setlocal ts=2 sts=2 sw=2 expandtab

" }}}-------------------------------------------------------------------------
"   Custom mappings                                                       {{{
" ----------------------------------------------------------------------------

" When pasting, refill the default register with what you just pasted
xnoremap p pgvy

" Repurpose arrow keys to navigating windows
nnoremap <left> <C-w>h
nnoremap <right> <C-w>l
nnoremap <up> <C-w>k
nnoremap <down> <C-w>j
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" To encourage the use of <C-[np]> instead of the arrow keys in ex mode, remap
" them to use <Up/Down> instead so that they will filter completions
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Navigate using displayed lines not actual lines
nnoremap j gj
nnoremap k gk

" Make Y consistent with D
nnoremap Y y$

" Reselect visual block after indent/outdent: http://vimbits.com/bits/20
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Allow saving of files as sudo when I forgot to start vim using sudo.
" Seems to have a problem where Vim sees that the file has changed and tries to
" reload it. When it does it thinks the file is blank (but it's not really).
cmap w!! %!sudo tee > /dev/null %

" Do what my fat fingers mean!
command! Bd bd
command! BD bd
command! Q q
command! W w
" Nobody ever uses this
noremap Q <nop>

" }}}-------------------------------------------------------------------------
"   Undo, Backup and Swap file locations                                  {{{
" ----------------------------------------------------------------------------

set noswapfile
set backupdir=$HOME/.vim/backupdir//
if exists('+undodir')
    set undodir=$HOME/.vim/undodir
    set undofile
endif

" }}}-------------------------------------------------------------------------
"   If there is a local .vimrc, source it here at the end                 {{{
" ----------------------------------------------------------------------------

if filereadable(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" }}}-------------------------------------------------------------------------
"                                                                         {{{
" ----------------------------------------------------------------------------
