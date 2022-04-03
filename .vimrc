" Options
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
"set inccommand=split
set mouse=a
set number
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu
set encoding=utf-8
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2

" Syntax
filetype plugin indent on
syntax on


" Plugins

call plug#begin()
  " Appearence
  Plug 'vim-airline/vim-airline'
  Plug 'ryanoasis/vim-devicons'
  
  " Syntax
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'MaxMEllon/vim-jsx-pretty'

  " Colorscheme
  Plug 'sainnhe/sonokai'

  " Utilities
  Plug 'preservim/nerdtree'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ap/vim-css-color'
  Plug 'ctrlpvim/ctrlp.vim'

  " Completion / linters / formatters
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" Colorscheme

" For st terminal make sense of termguicolors
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"


if has('termguicolors')
  set termguicolors
endif

let g:sonokai_style = 'atlantis'
let g:sonokai_better_performance = 1

colorscheme sonokai


" File browser
let NERDTreeShowHidden=1

" Ctrlp config
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" make ctrlp open file in new tab
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }


" Language server stuff
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Keybindings

" Normal mode remappings
nnoremap <C-q> :qa<CR>
nnoremap <C-s> :w<CR>
nnoremap <F4> :bd<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <F6> :sp<CR>:terminal<CR>

" Tabs
nnoremap <S-l> gt
nnoremap <S-h> gT

" Windows
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Refresh folder
nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>

"Coc setup

"Function to show the the diagnostics if it exists,
"otherwise the documentation, when hovering

" Tooltip for coc
nnoremap <silent> K :call CocAction('doHover')<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction



" goto actions
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" jump to the next or previous error
nmap <silent> [g <Plug>(coc-diagnostics-prev)
nmap <silent> ]g <Plug>(coc-diagnostics-next)

" Code actions are automated changes or fixes for an issue, such
" as automatically importanting a missing symbol. Code actions
" can be performed on the cursor with a mapping like the following
nmap <leader>do <Plug>(coc-codeaction)


" renaming a symbol
nmap <leader>rn <Plug>(coc-rename)

" use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>""

" Tabline
let g:airline#extensions#tabline#enabled = 1    " enable airline tabline
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            "
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline
