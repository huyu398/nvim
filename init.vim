" config directory setting by each OS {{{
if has('win32') || has('win64')
    let s:config_dir = $HOME . '/AppData/Local/nvim'
elseif has('unix')
    let s:config_dir = $HOME . '/.config/nvim'
else
    echomsg 'No setting on this OS.'
    finish
endif
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

        call dein#load_toml(l:toml, {'lazy' : 0})
        call dein#load_toml(l:toml_lazy, {'lazy' : 1})

        call dein#end()
        call dein#save_state()
    endif

    if dein#check_install()
        call dein#install()
    endif
endfunction

call init#dein()
" }}}

" plugins settings {{{
if dein#tap('vim-hybrid')
    set background=dark
    colorscheme hybrid
end
" }}}
