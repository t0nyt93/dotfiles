" Auto reload VIM Changes.
autocmd! bufwritepost .vimrc source %
set noswapfile
set backupcopy=yes

"---------Cursor Madness
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" ---- COLORSCHEME!! ----
" Currently using nord in init.vim
"colorscheme catppuccin-macchiato " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha


" (airline config removed — using lualine)

" Highlight cursor line (replaces conoline.vim)
set cursorline

" Alt window close behavior.
:nnoremap <Leader>q :Bdelete<CR>

nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

"---
highlight LineNr ctermfg=lightblue
highlight CocErrorHighlight ctermfg=1
highlight FgCocErrorFloatBgCocFloating ctermfg=1 guifg=#ff0000
highlight CocWarningHighlight ctermfg=10
highlight FgCocWarningFloatBgCocFloating ctermfg=3 guifg=#ff0000

" Generic VIM Configuration.
set autoread
set tabstop=4
set shiftwidth=4
set expandtab
set encoding=UTF-8
set updatetime=2000

" Display line numbers relative to cursor.
set relativenumber

command! -nargs=0 Tsc :call CocAction('runCommand', 'tsserver.watchBuild')


autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" Enable folding and indentation for YAML Files.
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

" Set default folding.
set foldmethod=indent
set foldcolumn=1
set foldlevelstart=99

set listchars=tab:\|\
set list

" Use K to show documentation in a floating window.
" Pressing K a second time focuses the floating window.
nnoremap <silent> A :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute 'h '.expand('<cword>')
  endif
endfunction

" Markdown Preview Access
" Use Grip Integration
let vim_markdown_preview_github=1
" Open in Brave, not Safari.
let vim_markdown_preview_browser='Brave Browser'
let g:mkdp_echo_preview_url=1
let vim_markdown_preview_hotkey='<C-m>'

nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cc :cclose<CR>

" --- Easier Buffer Navigation.
"  // Next buffer
nnoremap <Leader>bn :bn<CR>
"  // Back a buffer
nnoremap <Leader>bb :bp<CR>
"  // Previous buffer
nnoremap <Leader>bp :b#<CR>
nnoremap <Leader>l :ls<CR>

" --- Close the current buffer and open the previous one.
nnoremap <Leader>bc :bp\|bd #<CR>


let g:coc_node_args = ['--max-old-space-size=4096']

" Change window focus.
" Need to figure out how to work with Ack/AG menu.
tnoremap <Leader>w <c-w>w
nnoremap <Leader>w <c-w>w

" --------- Conquerer of Completion Settings -------------:
let g:coc_global_extenstions = ['coc-tsserver', 'coc-prettier', 'coc-eslint']
let g:coc_disable_transparent_cursor = 1

hi link CocFloating Normal
"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Jump to next/previous editor error
nmap <silent> <leader>A <Plug>(coc-diagnostic-next)

" Auto Select #1 on <CR> & <CR> for selected item...
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Use Tab & Shift+Tab to navigate the menu.
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Ctrl+. to manually trigger autocomplete
inoremap <silent><expr> <C-.> coc#refresh()

" Format via conform.nvim
nnoremap <leader>f :lua require("conform").format()<CR>

" (statusline config removed — lualine handles this)


" ------------ Telescope Mappings --------------
set wildignore+=*/.git/*,*/.idea/*,*/.DS_Store/*,*/node_modules/*,*/coverage/*,*/cdk.out/*

nmap <leader>vo <Plug>(coc-terminal-toggle)

" Search tracked Git files
nnoremap <leader>p <cmd>Telescope git_files<CR>

" Search open buffers
nnoremap <leader>b <cmd>Telescope buffers<CR>

" Search all available VIM commands
nnoremap <leader>c <cmd>Telescope commands<CR>

" Check out Git History
nnoremap <leader>h <cmd>Telescope git_commits<CR>

" Live grep (replaces Ag)
nnoremap <leader>s <cmd>Telescope live_grep<CR>

" Grep for word under cursor or visual selection
nnoremap <leader>ss <cmd>Telescope grep_string<CR>
vnoremap <leader>ss "zy<cmd>Telescope grep_string search=<C-r>z<CR>

" Open vim-fugitive Blame Buffer
nnoremap <leader>gb :Git blame<CR>


"Help out future Tony when he fat fingers save.
nnoremap :W :w


" Nerd Tree Command Overrides
nmap <leader>t :NERDTreeToggle<CR>


" Import ordering handled by coc-eslint autoFixOnSave (eslint-plugin-import/order)

" Reload files changed outside of Neovim
autocmd FocusGained,BufEnter * checktime
