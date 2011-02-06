set nocompatible

"tab stuff
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set encoding=utf-8
set backspace=indent,eol,start
set dictionary=/usr/share/dict/words
set mouse=n

"visual stuff
set showmatch
set ruler

set incsearch
set ignorecase
set smartcase

set showmode
set showcmd 

set scrolloff=10
set sidescrolloff=6

syntax on

if (&term == "iterm") || (&term == "putty")
  set background=dark
endif

colorscheme default

filetype plugin indent on
if(&filetype == "")
	set filetype=txt
endif

autocmd FileType c,cpp :set cindent
if has("autocmd")
    autocmd FileType python set complete+=k/home/trodrigues/.vim/pydiction-0.5/pydiction iskeyword+=.,(
endif " has("autocmd")

au BufNewFile,BufRead Jakefile set filetype=javascript

" make sure mixed types get all the snippets they need
autocmd FileType htmldjango :so ~/.vim/after/ftplugin/django_template_snippets.vim
autocmd FileType htmldjango :so ~/.vim/after/ftplugin/xhtml_snippets.vim

"CHECK THIS
"set omnifunc=cppomnicomplete#Complete 

set wildmode=list:longest,list:full

set history=100

set wrap
set comments+=b:\"
set formatoptions-=t
set textwidth=75

set modeline

" CTags CHECK ME
"map C-t :!ctags --extra=+f -R *<CR><CR>

"matching brackets
inoremap {     {}<Left>
inoremap }     }<Esc>
               \y2l
               \:if '}}'=="<C-R>=escape(@0,'"\')<CR>"<BAR>
               \  exec 'normal x'<BAR>
               \endif<CR>
               \a

inoremap [     []<Left>
inoremap ]     ]<Esc>
               \y2l
               \:if ']]'=="<C-R>=escape(@0,'"\')<CR>"<BAR>
               \  exec 'normal x'<BAR>
               \endif<CR>
               \a

inoremap (     ()<Left>
inoremap )     )<Esc>
               \y2l
               \:if '))'=="<C-R>=escape(@0,'"\')<CR>"<BAR>
               \  exec 'normal x'<BAR>
               \endif<CR>
               \a

"noremap <Space> <PageDown>
"noremap - <Pageup>

"navigate through files
"nnoremap <C-n> :next<CR>
"nnoremap <C-p> :prev<CR>
"navigate through tabs
"nnoremap <C-A-PageDown> :tabn<CR>
"nnoremap <C-n> :tabn<CR> "CHANGE TO UP/DOWN
"nnoremap <C-A-PageUp> :tabp<CR>
"nnoremap <C-p> :tabp<CR>

nnoremap <C-t> :tabfind 

cabbrev Wq wq

"follow help links
map <F7> <C-]>
"opens the file under the cursor on a split window
map <F8> <C-W>f <CR>
"NERDTree shortcuts
map <F2> :NERDTreeToggle<CR>
"Tag list plugin
map <F3> :TlistToggle<CR>

"change split windows forward/backward
nnoremap <F5> <C-W>w
nnoremap <S-F5> <C-W>W

"Change size of vertical split windows
map <F7> <C-W><
map <S-F7> <C-W>>

"Change size of horizontal split windows
map <F8> <C-W>+
map <S-F8> <C-W>-

"Paste toggle
nnoremap <F6> :set invpaste paste?<CR>
imap <F6> <C-O><F6>
set pastetoggle=<F6>

"VCS shortcuts
nnoremap <F9> :VCSCommit
nnoremap <S-F9> :VCSAdd
map <F12> :VCSLog<CR>
map <S-F12> :VCSStatus<CR>

"Command-T
nnoremap <D-t> :CommandT<CR>

set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat},              " file format
set statusline+=%{GitBranch()}]              " git branch
set statusline+=%=                           " right align
set statusline+=0x%-8B\                      " current char
set statusline+=%-10.(%l,%c%V%)\ %<%P        " offset

