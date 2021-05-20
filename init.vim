" Created By Jeremy Winterberg github.com/jeremydwayne

filetype plugin indent on

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged/')

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neovim/nvim-lspconfig'
Plug 'preservim/tagbar'

" Sensible Default Vim Config
Plug 'tpope/vim-sensible'

Plug 'vim-airline/vim-airline'

" File Switch Plugins
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" Plug 'ThePrimeagen/harpoon'

" Formatting / Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sbdchd/neoformat'
Plug 'rhysd/vim-clang-format'
Plug 'Yggdroot/indentLine'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'

Plug 'matze/vim-move'

" HTML shortcuts  ,y,
Plug 'mattn/emmet-vim'

" Snippets "
Plug 'Shougo/deoppet.nvim', { 'do': ':UpdateRemotePlugins' }

" Git
Plug 'tpope/vim-fugitive'
" Plug 'mhinz/vim-signify'


" Multiple Language Packs -- basically all of them
Plug 'sheerun/vim-polyglot'

" Auto end statement
Plug 'tpope/vim-endwise'

" Colored Parentheses
Plug 'p00f/nvim-ts-rainbow'

" gcc commenting
Plug 'tpope/vim-commentary'

" Markdown Support
Plug 'godlygeek/tabular'
Plug 'vimwiki/vimwiki'

" <C-n>
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Silver Searcher
Plug 'mileszs/ack.vim'

" GoLang
Plug 'fatih/vim-go'

" Rails
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" Javascript Plugins
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'typescript'] }
Plug 'claco/jasmine.vim', { 'for': ['javascript', 'typescript'] }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" Tags
Plug 'ludovicchabant/vim-gutentags'

call plug#end()

let mapleader=" "
inoremap jk <ESC>

let g:sync_async_upload = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>e :e! ~/.config/nvim/init.vim<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Or if you have Neovim >= 0.1.5

packadd! dracula_pro

syntax enable

let g:dracula_italic = 1
let g:dracula_colorterm = 0
colorscheme dracula_pro

lua require("configs")

" Open and Close QuickFix List
nnoremap <C-q> :copen<CR>
nnoremap <C-c> :cclose<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
" Open and Close Location List
nnoremap <leader>q :lopen<CR>
nnoremap <leader>c :lclose<CR>
nnoremap <leader>j :lnext<CR>
nnoremap <leader>k :lprev<CR>

" Coc Extensions "
let g:coc_global_extensions = [ 'coc-snippets', 'coc-pairs', 'coc-json', 'coc-solargraph' ]
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

vnoremap <LeftRelease> "*ygv"

" Fix airline fonts from not displaying correctly
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#formatter = 'unique_tail'

"Enable smarter tab line
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1


" vim-markdown
let g:vim_markdown_new_list_item_indent = 2
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'yaml', 'haml', 'bash=sh']

" vim-wiki
nmap <leader>whtml :VimwikiAll2HTML<cr>
nmap <leader>wit :VimwikiTable

" let g:user_emmet_leader_key='<Tab>'
" let g:user_emmet_settings = {
"             \  'javascript.jsx' : {
"             \      'extends' : 'jsx',
"             \  },
"             \}

"""""""""""""""""""""""""""""""
"" => MRU plugin
"""""""""""""""""""""""""""""""
"let MRU_Max_Entries = 400
"map <leader>f :MRU<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_next_key="\<C-s>"

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

"Harpoon Remaps
set exrc
" set secure
nmap <leader>th :call GotoBuffer(0)<CR>
nmap <leader>tj :call GotoBuffer(1)<CR>
nmap <leader>tk :call GotoBuffer(2)<CR>
nmap <leader>tl :call GotoBuffer(3)<CR>
nnoremap <silent> <C-_> :bnext<CR>
nnoremap <silent> <C-\> :bprevious<CR>
nnoremap <silent> <leader>bf :bfirst<CR>
nnoremap <silent> <leader>bl :blast<CR>
nnoremap <silent> <leader>bd :bd<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext


" Move lines of code around
" nnoremap <A-k> :m .-2<CR>==
" nnoremap <A-j> :m .+1<CR>==
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi
" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Remaps jk to ignore wrapped lines
" nmap j gj
" nmap k gk
nnoremap L $
nnoremap H ^


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")

" vertical line indentation
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'

" When reading a buffer (after 1s), and when writing.
" call neomake#configure#automake('rw', 1000)
" autocmd! BufWritePost,BufEnter * Neomake

let g:AutoClosePumvisible = {"ENTER": "<C-Y>", "ESC": "<ESC>"}

let g:syntastic_javascript_checkers = ['eslint']

" PHP CS FIXER
" let g:php_cs_fixer_path = "/home/linuxbrew/.linuxbrew/bin/php-cs-fixer"
" let g:php_cs_fixer_config_file = "~/.dotfiles/php_cs"
" nnoremap <silent><A-D> :call PhpCsFixerFixDirectory()<CR>

" Neoformat
" let g:neoformat_basic_format_retab = 1
" let g:neoformat_only_msg_on_error = 1
nnoremap <silent><A-F> :Neoformat<CR>
let g:neoformat_enabled_php = ['phpcsfixer']
let g:neoformat_php_phpcsfixer = {
            \ 'exe': 'php-cs-fixer',
            \ 'args': ['fix', '-q', '--config', '~/.dotfiles/php_cs'],
            \ 'replace': 1,
            \ }

" xmap <C-_> <Plug>Commentary
" nmap <C-_> <Plug>Commentary
" omap <C-_> <Plug>Commentary
" nmap <C-_> <Plug>CommentaryLine
" nmap <C-_>a gcgc


" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nmap <A-8> :TagbarToggle<CR>

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup jeremydwayne
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd FileType vim let b:coc_pairs_disabled = '"'

    " Conceal Level is dumb
    autocmd InsertEnter *.json setlocal conceallevel=0 concealcursor=
    autocmd InsertLeave *.json setlocal conceallevel=2 concealcursor=inc
    autocmd InsertEnter *.md setlocal conceallevel=0 concealcursor=
    autocmd InsertLeave *.md setlocal conceallevel=2 concealcursor=inc
    au BufNewFile,BufRead *.jinja set syntax=htmljinja
    au BufNewFile,BufRead *.mako set ft=mako

    au FileType gitcommit call setpos('.', [0, 1, 1, 0])

    autocmd! bufwritepost vimrc source ~/.vimrc
    " Markdown and VimWiki Filetypes
    autocmd BufRead,BufNewFile *.md setlocal spell
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

    autocmd BufRead,BufNewFile *.wiki setlocal spell
    au BufNewFile,BufFilePre,BufRead *.wiki set filetype=wiki
    " Close NerdTree when vim exits
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " Syntax Hilighting for ANTLR
    au BufRead,BufNewFile *.g set syntax=antlr3
    " New File Skeletons
    autocmd BufNewFile *
                \ let templatefile = expand("~/.dotfiles/templates/") . expand("%:e")|
                \ if filereadable(templatefile)|
                \   execute "silent! 0r " . templatefile|
                \   execute "normal Gdd/CURSOR\<CR>dw"|
                \ endif|
    au TabLeave * let g:lasttab = tabpagenr()
    " Return to last edit position when opening files (You want this!)
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Neoformat
    autocmd BufWritePre *.js Neoformat
    autocmd BufWritePre *.jsx Neoformat
    autocmd BufWritePre *.php Neoformat
    autocmd BufWritePre *.go Neoformat
    autocmd BufWritePre *.ruby Neoformat
    autocmd BufWritePre *.css Neoformat
    autocmd BufWritePre *.html Neoformat

    " Generate CTags for PHP
    au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

    " autocmd BufEnter * lua require'completion'.on_attach()
    autocmd FileType php setlocal commentstring=//\ %s
augroup END
