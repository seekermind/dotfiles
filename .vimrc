call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    let g:UltiSnipsEditSplit="vertical"
Plug 'honza/vim-snippets'

Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
	let g:livepreview_previewer = 'zathura'

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'chrisbra/unicode.vim'
Plug 'preservim/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'ap/vim-css-color'
Plug 'miyakogi/conoline.vim'
Plug 'arcticicestudio/nord-vim'
" Using plug
Plug 'dylanaraps/wal.vim'
"

call plug#end()


command! Q :q

inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>


" correcting mistakes on the fly, inspire by https://castel.dev/post/lecture-notes-1/
"setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
set confirm

filetype plugin on
set number
"colorscheme nord
colorscheme wal

"auto enable cursorline style by conoline
let g:conoline_auto_enable = 1
let g:conoline_color_normal_light = "ctermbg=240"
let g:conoline_color_normal_nr_light = "ctermbg=240 ctermfg=white"
let g:conoline_color_insert_light = "ctermbg=237"
let g:conoline_color_insert_nr_light = "ctermbg=red"

"There is also options to use colorscheme's colors:

"let g:conoline_use_colorscheme_default_normal=1
"let g:conoline_use_colorscheme_default_insert=1

"suggested by vim-devicons
set encoding=UTF-8

"nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>
"let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" resizing vertical and horizontal split
nnoremap <silent> <S-left> :vertical resize -5<cr>
nnoremap <silent> <S-down> :resize +5<cr>
nnoremap <silent> <S-up> :resize -5<cr>
nnoremap <silent> <S-right> :vertical resize +5<cr>


"here comes coc vim
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

"To make <cr> select the first completion item and confirm the completion when
"no item has been selected
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" from coc-snippets to make sure tab takes to next placeholder even when the
" snippet is selected from coc menu by <cr>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

