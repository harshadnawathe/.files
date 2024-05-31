call plug#begin('~/.local/share/vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-rsi'

Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'rose-pine/vim', { 'as': 'rose-pine' }


call plug#end()

" Use macos clipboard
set clipboard=unnamed

" line numbers
set number
set relativenumber

" tab settings
set tabstop=2
set shiftwidth=2
set expandtab

set termguicolors

set notimeout

colorscheme catppuccin_mocha
