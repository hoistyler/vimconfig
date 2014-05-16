" It is essential that these lines are called before enabling filetype detection, so I would recommend putting them at the top of your vimrc file.
" pathogen
call pathogen#infect()
call pathogen#helptags()


" ~/.vimrc (configuration file for vim only)
" skeletons
function! SKEL_spec()
	0r /usr/share/vim/current/skeletons/skeleton.spec
	language time en_US
	if $USER != ''
	    let login = $USER
	elseif $LOGNAME != ''
	    let login = $LOGNAME
	else
	    let login = 'unknown'
	endif
	let newline = stridx(login, "\n")
	if newline != -1
	    let login = strpart(login, 0, newline)
	endif
	if $HOSTNAME != ''
	    let hostname = $HOSTNAME
	else
	    let hostname = system('hostname -f')
	    if v:shell_error
		let hostname = 'localhost'
	    endif
	endif
	let newline = stridx(hostname, "\n")
	if newline != -1
	    let hostname = strpart(hostname, 0, newline)
	endif
	exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
	exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
	exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
	setf spec
endfunction
autocmd BufNewFile	*.spec	call SKEL_spec()
" filetypes
filetype plugin on
filetype indent on
" ~/.vimrc ends here


" My custom vimrc

" function vs function!
" When a function by this name exists and [!] is not given, then an error
" message is given. Otherwise it is replaces unless it is currently being
" excuted
function! TAGS_Load(tagfile)
    let filename=a:tagfile
    if filereadable(filename)
        "echo "Autoloading tagfile += ".filename
        execute "set tags+=".filename
    endif
endfunction

set nocompatible "this must be first, because it changes other options as side effect
                 "this option stops vim from behaving in a strongly vi -compatible way. 
                 "It should be at the start of any vimrc file as it can affect lots of other options which you may want to override

syntax on

set t_Co=256    "256 color
set mouse=a     "enable mouse"
set tabstop=4   "a tab is four spaces"
set expandtab   "tab as spaces"
set cin
set cino=:0
set incsearch
set hlsearch
set shiftwidth=4    "number of spaces to use for autoindenting
set shiftround  "use multiple of shiftwidth when indenting with '<' and '>' (in insert mode, use CTRL-T CTRL-D)
set number  "always show line numbers
set nobackup        "no backup files
set nowritebackup   "no backup files
set noswapfile      "no backup files
set nowrap  "don't wrap lines
set ignorecase  "ignore case when searching
set smartcase
set wildmenu
set scrolloff=4 "keep 4 lines off the edges of the screen when scrolling
set showmatch "show matching braces when the indicator is over one
set hidden "hide the buffer instead of closing them (can open other files without writing to the buffer)
set backspace=indent,eol,start  "allow backspacing over everything in insert mode
set copyindent  "copy the previous indentation on autoindenting
set history=100    "remember more commands
set undolevels=1000     "do more undos
set title   "change the terminal's title
set visualbell  " don't beep
set noerrorbells    "don't beep
set splitright " new window on the right instead of on the left
set switchbuf=split " opens files from quickfix to split

set path=game/**,../../platform/src/**


set wildignore+=*.so,*.d,*.o

"make vim use bash with .bashrc loaded (Does not work with vimdiff?)
"set shell=bash 
let $BASH_ENV = '~/.bashrc'
set shellcmdflag=-O\ expand_aliases\ -c
"set shellcmdflag=-ic

autocmd BufEnter * set cin | set cino=:0 | set nowrap
"autocmd BufWritePost *.c,*.h,*.cpp,*.hpp execute "call Re_GameTAG()"
"


" below line seems to have broken vim exit where it prints out random
" characters 
"autocmd VimLeave * :set term=xterm-256color

nnoremap <silent> <C-L> :nohls<CR><C-L>
inoremap <silent> <C-L> <C-O>:nohls<CR><C-L>

" Load tags automatically
call TAGS_Load("tags_platform")


" My Colors
" if &diff
"     colorscheme mustang
" else
"     colorscheme solarized
" endif

colorscheme molokai
set background=light


"remove any window stuff
if has('gui')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
    set guioptions-=l
    set guioptions-=R
    set guioptions-=r
else
    set laststatus=2                                "always display status line
    set statusline=                                 "clear statusline
    set statusline=%f                               "tail of the filename (use %t for onlt filename)
    set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
    set statusline+=%{&ff}]                         "file format
    set statusline+=%h                              "help file flag
    set statusline+=%m                              "modified flag
    set statusline+=%r                              "read onlt flag
    set statusline+=%y                              "filetyle
    set statusline+=%=                              "left/right separator
    set statusline+=%c,                             "cursor column
    set statusline+=%l/%L,                          "cursor line/total lines
    set statusline+=\ %P,                           "percent throught file
end

" My search key maps
"nnoremap <F2> :Egrep -RI
"Grep
"let Grep_Default_Filelist='game'
"let Grep_Skip_Files='*.d *.o'

if has("gui_running")
    "font
    set guifont=Liberation\ Mono\ 12
    "keymap for CTRL space
    "gvim does not recieve C-@ as Null like terminal.
    " this is to get cscope keymaps to work
    nmap <C-Space> <C-@>
    nmap <C-Space><C-Space> <C-@><C-@>
else
endif

"F5 to refresh
nnoremap <silent><F5> :e<CR>

"make keys
nnoremap <silent><F7> :make clean<CR>
nnoremap <silent><F6> :make games<CR>


" Close Buffer key map
nnoremap <silent><F9> :bd<CR>

"""""""""""""""""""" Below for vim scripts

