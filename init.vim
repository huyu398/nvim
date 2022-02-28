" vim: foldlevel=0
" config directory setting by each OS {{{
if has('win32') || has('win64')
    let s:config_dir = $HOME . '/AppData/Local/nvim'
    let g:python3_host_prog = 'C:\Users\' . $USERNAME . '\Anaconda3\python.exe'
elseif has('unix')
    let s:config_dir = $HOME . '/.config/nvim'
else
    echomsg 'No setting on this OS.'
    finish
endif
" }}}

let g:loaded_python_provider=0
let g:loaded_ruby_provider=0
let g:loaded_node_provider=0
let g:loaded_perl_provider=0

" basic settings {{{
" options {{{
set autochdir

set mouse-=a

set number
set cursorline
set wildmode=list:full

set foldmethod=marker
set foldlevelstart=10

set list
set listchars=tab:▸\ ,eol:¬

set splitbelow
set splitright

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set noswapfile
if has('persistent_undo')
    let s:undo_dir = expand(s:config_dir . '/undo')
    if !isdirectory(s:undo_dir)
        call mkdir(s:undo_dir)
    endif
    let &undodir = s:undo_dir
    set undofile
    unlet s:undo_dir
endif

set ignorecase
" }}}

" mappings {{{
inoremap jj <ESC>

noremap j gj
noremap k gk

noremap H gT
noremap L gt

if has('nvim')
    tnoremap <ESC> <C-\><C-N>
    nnoremap <Leader>s :terminal<CR>
endif

" No need cursor key on normal, visual, and insert mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
" }}}
" }}}

" dein.vim settings {{{
function! init#dein() abort
    " check git command
    if !executable('git')
        echoerr "No command 'git' found."
        return
    end

    " directory for dein.vim
    let l:dein_dir = s:config_dir . '/dein'
    let l:dein_repo_dir = l:dein_dir . '/repos/github.com/Shougo/dein.vim'

    " git clone dein.vim unless dein repository exist
    if &runtimepath !~# '/dein.vim'
        if !isdirectory(l:dein_repo_dir)
            execute '!git clone http://github.com/Shougo/dein.vim' l:dein_repo_dir
        endif
        execute 'set runtimepath+=' . l:dein_repo_dir
    endif

    if dein#load_state(l:dein_dir)
        call dein#begin(l:dein_dir)

        let l:toml = s:config_dir . '/dein.toml'
        let l:toml_lazy = s:config_dir . '/dein_lazy.toml'
        let l:toml_lang = s:config_dir . '/dein_lang.toml'

        call dein#load_toml(l:toml, {'lazy' : 0})
        call dein#load_toml(s:config_dir . '/defx.toml', {'lazy': 1})
        call dein#load_toml(l:toml_lazy, {'lazy' : 1})
        call dein#load_toml(l:toml_lang, {'lazy' : 1})

        call dein#end()
        call dein#save_state()
    endif

    if dein#check_install(['vimproc.vim'])
        call dein#install(['vimproc.vim'])
    endif
    if dein#check_install()
        call dein#install()
    endif
endfunction

call init#dein()
" }}}

filetype indent plugin on
