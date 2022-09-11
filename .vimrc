call plug#begin()
" Tabline Customization
Plug 'vim-airline/vim-airline'
"Plug 'itchyny/lightline.vim'
Plug 'miyakogi/conoline.vim'

" NERDTree && Tags/Tagbar.
Plug 'scrooloose/nerdtree'
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'

"Plug 'puremourning/vimspector'
"Plug 'tpope/vim-fugitive'


" Typescript/Javascript Setup..
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" GraphQL file detection/syntax highlighting.
Plug 'jparise/vim-graphql'

" Some basic vimmage
Plug 'jiangmiao/auto-pairs'
Plug 'felixhummel/setcolors.vim'

"/* Not the best Tag generator, but definitely the most robust/simple */

Plug 'brooth/far.vim'
" UltiSnips 
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


"*/* Prettier integration. */
Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install --frozen-lockfile --production', 
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'typescriptreact', 'javascriptreact']
    \ }

" Auto Completion
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"/* Fancier NerdTree Icons/Style */
Plug 'liuchengxu/vista.vim'
Plug 'ryanoasis/vim-devicons'

"/* Dis be the brains of your operation. */
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }

call plug#end()

" Disable problematic issue of cursor disappearing after leaving COC
" Completion Menu.
let g:coc_disable_transparent_cursor = 1

" Auto reload VIM Changes.
autocmd! bufwritepost .vimrc source %
set noswapfile

" Generic VIM Configuration.
set autoread
set tabstop=4
set shiftwidth=4
set expandtab
colorscheme zenburn
set encoding=UTF-8
set guifont="Sauce\ Code\ Pro"
set guifont=:h14

set colorcolumn=100

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact


set relativenumber

" Enable folding and indentation for YAML Files.
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" Set default folding.
set foldmethod=indent
set foldcolumn=1
set foldlevelstart=99

set listchars=tab:\|\
set list

" Easier Buffer Navigation.
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>l :ls<CR>

let g:vimspector_enable_mappings = 'HUMAN'

" Conoline - Highlight current line.
let g:conoline_auto_enable = 1
let g:conoline_use_colorscheme_default_normal = 1
let g:conoline_use_colorscheme_default_insert = 1

let g:coc_node_args = ['--max-old-space-size=4096']

" Change window focus.
" Need to figure out how to work with Ack/AG menu.
tnoremap <Leader>w <c-w>w<CR>
nnoremap <Leader>w <c-w>w<CR>

" --------- Vim Markdown Preview -------------------------:
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 10 
nmap <C-p> <Plug>MarkdownPreviewToggle

" --------- Conquerer of Completion Settings -------------:
let g:coc_global_extenstions = ['coc-tsserver', 'coc-eslint']

nmap <leader>ca <Plug>(coc-codeaction)
nmap <leader>cf <Plug>(coc-fix-current)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"---- Below taken from the coc.vim README.
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" COC -- Prettier?
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <leader>f :Prettier<CR>

" ////--------- Conquerer of Completion Settings ------------- ////:
" ------------- Vista! -------------------
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
nnoremap <leader>b Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'ts': 'vim_lsp',
  \ 'js': 'vim_lsp',
  \ 'yml': 'vim_lsp',
  \ 'yaml': 'vim_lsp',
  \ }

let g:vista_ctags_cmd = {}

" To enable fzf's preview window set g:vista_fzf_preview.
" -------- LIGHTLINE ------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'method' ] ]
      \ },
      \ 'component_function': {
      \   'method': 'NearestMethodOrFunction'
      \ },
      \ }
" ----------------------------
" /------------ Vista! ------------------/

" ------------ FZF Mappings/Settings --------------
set wildignore+=*/.git/*,*/.idea/*,*/.DS_Store/*,*/node_modules/*,*/coverage/*

" Ultimate navigation - .
nnoremap <leader>p :GFiles<CR>
nnoremap <leader>s :Ag<CR>
nnoremap :W :w

" -------------    UltiSnips     -------------- "
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Nerd Tree Command Overrides
nmap <leader>t :NERDTreeToggle<CR>

" ----------------- FaR - Find and Replace -------
set lazyredraw            " improve scrolling performance when navigating through large results
set regexpengine=1        " use old regexp engine
set ignorecase smartcase  " ignore case only when the pattern contains no capital letters

" shortcut for far.vim find
nnoremap <silent> <F10> :Farf<cr>
vnoremap <silent> <F10> :Farf<cr>

" shortcut for far.vim replace
nnoremap <silent> <F9> :Farr<cr>
vnoremap <silent> <F9> :Farr<cr>


" ----------------- Lets get Tags!----------------
"  " tags
set tags=.tags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'

let g:gutentags_modules = ['ctags']

let g:gutentags_cache_dir = expand('~/.cache/tags')

let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

nmap <F12> :TagbarOpen j<CR>
nmap <F10> :TagbarClose<CR>
" ------------------------------------------------
" TERMINAL
function! PutTermPanel(buf, side, size) abort
  " new term if no buffer
  if a:buf == 0
    term
  else
    execute "sp" bufname(a:buf)
  endif
  " default side if wrong argument
  if stridx("hjklHJKL", a:side) == -1
    execute "wincmd" "J"
  else
    execute "wincmd" a:side
  endif
  " horizontal split resize
  if stridx("jkJK", a:side) >= 0
    if ! a:size > 0
      resize 6
    else
      execute "resize" a:size
    endif
    return
  endif
  " vertical split resize
  if stridx("hlHL", a:side) >= 0
    if ! a:size > 0
      vertical resize 6
    else
      execute "vertical resize" a:size
    endif
  endif
endfunction

function! s:ToggleTerminal(side, size) abort
  let tpbl=[]
  let closed = 0
  let tpbl = tabpagebuflist()
  " hide visible terminals
  for buf in filter(range(1, bufnr('$')), 'bufexists(bufname(v:val)) && index(tpbl, v:val)>=0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      silent execute bufwinnr(buf) . "hide"
      let closed += 1
    endif
  endfor
  if closed > 0
    return
  endif
  " open first hidden terminal
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)<0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      call PutTermPanel(buf, a:side, a:size)
      return
    endif
  endfor
  " open new terminal
  call PutTermPanel(0, a:side, a:size)
endfunction

" Toggle terminal - bottom
nnoremap <silent> <leader>vb :call <SID>ToggleTerminal('J', 6)<CR>

" Toggle terminal - right
nnoremap <silent> <leader>vr :call <SID>ToggleTerminal('L', 60)<CR>
