let s:nvim_path = expand('~/.config/nvim')

"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
if dein#load_state('/Users/zenet/.cache/dein')
  call dein#begin('/Users/zenet/.cache/dein')
  call dein#load_toml(s:nvim_path . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:nvim_path . '/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on
syntax enable
" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts------------------------

colorscheme molokai
syntax on
set t_Co=256
set title
set number
set ambiwidth=double
set tabstop=4
set noexpandtab
set shiftwidth=4
set softtabstop=0


"keymap
nnoremap <silent><C-e> :NERDTreeToggle<CR>
