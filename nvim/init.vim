"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/zenet/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/zenet/.cache/dein')
  call dein#begin('/Users/zenet/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/zenet/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  call dein#load_toml('~/.cache/dein/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.cache/dein/dein_lazy.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
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