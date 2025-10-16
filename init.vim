" VSCode Neovimかどうかを判定
if exists('g:vscode')
  " ========================================
  " VSCode Neovim用の設定
  " ========================================
  
  " 基本設定
  set clipboard=unnamed
  set number
  
  " キーマッピング
  inoremap jj <Esc>
  cnoremap jj <Esc>
  
  " VSCodeと互換性のあるプラグインのみ
  call plug#begin('~/.config/nvim/plugged')
  Plug 'tpope/vim-commentary'      " コメントアウト（VSCodeでも動く）
  Plug 'tpope/vim-surround'        " 括弧操作（VSCodeでも動く）
  Plug 'jiangmiao/auto-pairs'      " 括弧の自動補完（VSCodeでも動く）
  call plug#end()
  
  " VSCodeのコマンドを使う
  nnoremap <C-p> <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  nnoremap <C-f> <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>

else
  " ========================================
  " 通常のNeovim用の設定
  " ========================================
  
  syntax on
  colorscheme molokai
  set t_Co=256
  set encoding=utf8
  set tabstop=2
  set shiftwidth=2
  set number
  set scrolloff=999
  set clipboard=unnamed
  
  inoremap jj <Esc>
  cnoremap jj <Esc>
  tnoremap jj <C-\><C-n>
  
  command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
  autocmd TermOpen * startinsert
  
  let g:loaded_perl_provider = 0
  let g:loaded_ruby_provider = 0
  let g:python3_host_prog = '/usr/bin/python3'
  
  call plug#begin('~/.config/nvim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-commentary'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'jiangmiao/auto-pairs'
  Plug 'honza/vim-snippets'
  call plug#end()
  
  nmap <C-f> :NERDTreeToggle<CR>
  nmap <C-p> <Plug>AirlineSelectPrevTab
  nmap <C-n> <Plug>AirlineSelectNextTab
  
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_theme = 'simple'
  let g:airline_deus_bg = 'dark'
  let g:airline_powerline_fonts = 1
  
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction
  
  inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"
  inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
  inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>"
  inoremap <silent><expr> <c-space> coc#refresh()

endif
