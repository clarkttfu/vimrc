" Basic {
    set nocompatible
    set autoread                    " auto load file when updated outside
    set nobackup                    " turn off backup
    set nowb                        " turn off backup
    set history=200                 " lines of Ex-mode commands, search history
    set hidden                      " allow buff switching without saving
    set fileencoding=utf-8
    set fileencodings+=utf-8
    set fileencodings+=gbk

    filetype off                    " required

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'easymotion/vim-easymotion'
    call vundle#end()               " required
    filetype plugin indent on       " required
" }

" UI {
    colors desert
    if &diff
        color murphy
        set background=dark
    endif
    " splash: convert backsplash, unix: EOL
    set viewoptions=folds,options,cursor,unix,slash
    " backspacing over everything
    set backspace=indent,eol,start 
    set virtualedit=onemore " one cursor beyond last char
    set nu	                " show line number
    set showmode            " display current mode
    set cursorline          " hight current line
    set nowrap

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " ruler on steroids
        " show partial commands in status line andselected characters/lines in visual mode
        set showcmd
    endif

    if has('statusline')
        set laststatus=2
        if &runtimepath =~ 'vim-fugitive'
          set statusline=%{fugitive#statusline()}
        endif
        set statusline+=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    "set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
    "set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:.
    set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:. 
    set nolist

" }

" Editing {
    syntax enable
    syntax on
    set showmatch
    set incsearch           " find as you type in
    set hlsearch            " highlight match items
    set ignorecase          " case-insensitive search
    set smartcase                   " case sensitive when upper case char presents
    filetype on
    filetype plugin on
    filetype indent on

    set autoindent
    set expandtab           " space only
    set smarttab            " smarttab
    set tabstop=2           " tab spacing
    set softtabstop=2       " let backspace delete indent
    set shiftwidth=2

    " Folding {
        "set foldenable
        "set foldnestmax=3
        "set foldlevel=0
        "set foldmarker={,}
        "set foldmethod=indent
        "set foldmethod=marker
        " help fold:
        "   zM/zR: fold/unfold everything
        "   zm/zr: fold more or less
        "   zc/zo: fold/unfold at cursor
        " help fold-commands
        " set nofoldenable
        " set foldmarker={,} foldlevel=0 foldmethod=marker
    " }
" }

" Mapping {

    " override default <leader> char '\'
    let mapleader = ','

    " cd to current file directory
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
    map <leader>cd :cd %:h<CR>:pwd<CR>

   " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_
    map <S-H> gT
    map <S-L> gt

    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " replace all matches under cursor
    :nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

    " Adjust viewports to the same size
    map <Leader>= <C-w>=
    " close current tab
    map <C-w><C-d> :tabc<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Leave the editor with Ctrl-q (KDE): Write all changed buffers and exit
    nnoremap  <C-q>    :wqall<CR>
    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$
    " change Windows path separator char to UNIX format
    nnoremap <silent>sp <Esc>:s/\\/\//g<CR>
    " insert empty line above
    nnoremap <silent><M-K> :set paste<CR>m`O<Esc>``:set nopaste<CR>
    " delete empty line below
    nnoremap <silent><M-J> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk

    """ Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap z[ :%foldc<CR>
    nmap z] :%foldo<CR>

    "clearing highlighted search
    nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

    " comma always followed by a space
    " inoremap  ,  ,<Space>

    " insert current file name
    :inoremap <leader>fn <C-R>=expand("%:t")<CR>
    ":inoremap \fn <C-R>=expand("%:t:r")<CR> without suffix
    ":inoremap \fn <C-R>=expand("%:p:h")<CR> absolute path
    ":inoremap \fn <C-R>=expand("%:h")<CR> ralative path

    " Fix home and end keybindings for screen, particularly on mac
    " - for some reason this fixes the arrow keys too. huh.
    map ^[[F $
    imap ^[[F ^O$
    map ^[[H g0
    imap ^[[H ^Og0

    " Stupid shift key fixes
    cmap WQ wq
    cmap wQ wq
    cmap Tabe tabe

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>

    " visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " autocomplete quotes (visual and select mode)
    xnoremap  '  s''<Esc>P<Right>
    "xnoremap  "  s""<Esc>P<Right>
    xnoremap  `  s``<Esc>P<Right>
" }

" Plugin {

    " easymotion
    let g:EasyMotion_smartcase = 1
    map <Leader> <Plug>(easymotion-prefix)
    " JK motions: Line motions
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)

    " Tagbar
    nmap <F8> :TagbarToggle<CR>

    " Tabular
    if exists(":Tabularize")
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a| :Tabularize /|<CR>
      vmap <Leader>a| :Tabularize /|<CR>
      nmap <Leader>a: :Tabularize /:\zs<CR>
      vmap <Leader>a: :Tabularize /:\zs<CR>
    endif

" }

" autocmd {
    if has("autocmd")
        autocmd FileType make set noexpandtab

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).    
        autocmd BufReadPost *
                  \ if line("'\"") > 0 && line("'\"") <= line("$") |
                  \   exe "normal! g`\"" |
                  \ endif
        " change the working directory to the directory containing the current file
        " autocmd BufEnter * :lchdir %:p:h
    endif " has("autocmd")
" }

