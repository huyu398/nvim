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
