set encoding=utf-8
set nocompatible

" To install plug, run
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" Replace/delete word in multiple places, iteratively
Plug 'konfekt/vim-select-replace'
" All languages, dynamically loaded?
Plug 'sheerun/vim-polyglot'
" A decent-looking colorscheme
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
" Any-project navigation like vim-rails
Plug 'tpope/vim-projectionist'
" Rails navigation
Plug 'tpope/vim-rails'
" Better git mergetool
Plug 'whiteinge/diffconflicts'
" Run substitution on steriods
Plug 'tpope/vim-abolish'
" Run shell commands like :Remove or :Mkdir
Plug 'tpope/vim-eunuch'
" Run git commands like :Gblame or :Gread
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
set tags^=./.git/tags;  " Consider removing and fixing ctags config
" Make increment/decrement work on dates
Plug 'tpope/vim-speeddating'
" Recursive directory diff. Rarely needed but indespensible.
Plug 'vim-scripts/DirDiff.vim'
" Mapping for 'surround' actions, like cs"' for `change the surrounding
" double-quotes to single-quotes`
Plug 'tpope/vim-surround'
" toggle comments
Plug 'tpope/vim-commentary'
" Run tests on save
Plug 'tpope/vim-dispatch'
" Ember navigation
Plug 'andrewradev/ember_tools.vim'
let g:ember_tools_extract_behaviour = 'component-dir'
" Make '.' repeat more complicated actions
Plug 'tpope/vim-repeat'
" Filetype detection for ember-style .hbs files
Plug 'mustache/vim-mustache-handlebars'
" This gives me the "extract assignment into let-binding" for rspec
Plug 'ecomba/vim-ruby-refactoring'
" Copy text from vim to another page
Plug 'jpalardy/vim-slime'
" Set vim-slime to use tmux instead of screen
let g:slime_target = "tmux"
" Visual select and then mark two chunks via :Linediff
Plug 'AndrewRadev/linediff.vim'
" Wiki-wiki-what?
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'syntax': 'markdown'}]
" Syntax highlighting for ansible files
Plug 'pearofducks/ansible-vim'
let g:ansible_unindent_after_newline = 1
" Async linting.
" Requires per-language tools (rubocop,eslint) installed outside of vim.
" Better than syntastic b/c async.
Plug 'w0rp/ale'
" nnoremap mm :ALENextWrap<CR>
let g:ale_linters = {'ruby': ['rubocop'], 'javascript': ['eslint'], 'elixir': []}
let g:ale_fixers = {'ruby': ['rubocop'], 'javascript': ['eslint'], 'elixir': ['mix_format'], 'css': ['stylelint'], 'scss': ['stylelint']}
let g:ale_fixerst = { 'ruby': ['rubocop'] }
let g:ale_fix_on_save = 1
" Swap two words
Plug 'machakann/vim-swap'
" Task list, need to play around with learning
Plug 'aaronbieber/vim-quicktask'
" PSQL syntax & completion
Plug 'lifepillar/pgsql.vim'
let g:sql_type_default = 'pgsql'
" VSCode completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
runtime coc.vimrc
nmap mm <Plug>(coc-diagnostic-next)
" Move to closing )]} instead of adding more
" Plug 'jiangmiao/auto-pairs'
" Run tests
Plug 'janko/vim-test'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" au Filetype elixir let b:dispatch = 'mix test'
" au FileWritePost *.leex exec '!rustywind --write' shellescape(@%, 1)
" au FileWritePost *.eex exec '!rustywind --write' shellescape(@%, 1)

au FileType sql setl formatprg=pg_format\ -b\ -f\ 1\ -u\ 1\ -
colorscheme seoul256
set bg=dark
highlight Comment cterm=italic

" Remove trailing spaces on file save
autocmd BufWritePre     * :%s/\s\+$//e

set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set confirm
set encoding=utf8
set expandtab
set foldcolumn=3
set history=10000
set hlsearch
set ignorecase
set smartcase
set incsearch
set lazyredraw
set laststatus=2 " Always show filename
set listchars=tab:>-,trail:…
set nowrap
set pastetoggle=<F5>
set ruler
set scrolloff=7
set shiftwidth=2
set shortmess=atI
set showcmd
set showmatch
set sidescroll=8
set softtabstop=2
set splitright
set switchbuf=useopen
set ttyfast " 2019-06-04 08:53:12 AM Tue https://aonemd.github.io/blog/minimal-vim
set virtualedit=block
set wildmenu
set list
set undodir=~/.vim/undodir
set undofile
" Turn on per-folder .vimrc sourcing
set exrc
" Make per-folder .vimrc files safer
set secure
set tabpagemax=99
set directory=~/.vim_swap
set cryptmethod=blowfish2
set equalalways
let mapleader = ','

"" Make 81st column stand out
" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%81v', 100)

"Auto open-close quickfix wIndow (make/grep/etc)
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Spelling enabled on prose
autocmd FileType gitcommit setlocal spell spelllang=en spellfile=~/.vim/spell/en.utf-8.add
autocmd FileType vimwiki setlocal spell spelllang=en spellfile=~/.vim/spell/en.utf-8.add

" Mapping for storing wiki in git
function! StoreVimwiki()
  let cmd = 'cd ~/vimwiki/ && git add --all && git commit -m "autocommit" --no-gpg-sign'
  let resp = system(cmd)
endfunction
autocmd BufWritePost */vimwiki/* call StoreVimwiki()

"Fix cron on OSX
"Avoids error 'crontab: temp file must be edited in place'
autocmd FileType crontab set backupskip=/tmp/*,/private/tmp/*
" re-indent xml
map <F3> :%s/>\s*</>\r</g<CR>:set ft=xml<CR>gg=G
" re-indent json
map <F4> :%s/{/{\r/g<CR>:%s/}/\r}/g<CR>:%s/,/,\r/g<CR>:set ft=javascript<CR>gg=G
map <Leader>f ?\<it\\|describe\\|context\><cr>if<esc>:nohlsearch<cr>
map <Leader>g ?\<fit\\|fdescribe\\|fcontext\><cr>x:nohlsearch<cr>

map ,p :w<CR><ESC>:%!prettier %<CR>

" Vertical split to file under cursor
map gv :vertical wincmd f<CR>

" 'Maximize' a split window
nnoremap <C-W>M <C-W>\| <C-W>_
nnoremap <C-W>m <C-W>=

" janko/vim-test                  "
nmap <Leader>tn :TestNearest<CR>  "
nmap <Leader>tf :TestFile<CR>     "
nmap <Leader>ts :TestSuite<CR>    "
nmap <Leader>tl :TestLast<CR>     "
nmap <Leader>tg :TestVisit<CR>    "
                                  "
nmap <Leader>tt :TestLast<CR>     "
nmap <Leader>, :TestLast<CR>     "
let test#strategy = "dispatch"    "
" janko/vim-test                  "


" Make git commits show a preview pane
autocmd! BufReadPost gitcommit
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
autocmd FileType gitcommit setlocal spell spelllang=en_us
" autocmd FileType gitcommit colorscheme nord
autocmd FileType gitcommit DiffGitCached | wincmd L

inoremap ppp <Bar>>

" Mappings
map QQ :q<CR>
map WW :wall<CR>
" map WW :wall\|:Dispatch<CR>
map NN :next<CR>
map PP :previous<CR>
map VV :w\| :so ~/.vimrc\| :PlugInstall<CR>
map avd :!ansible-vault decrypt %<CR>
map ave :!ansible-vault encrypt %<CR>
" Alias for the sudo write trick, I never remember the exact sequence
cmap SS w !sudo tee %
" Good enough tab completion
" imap <Tab> <C-N>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>
nnoremap <CR> :nohlsearch<cr>
" cabbrev h vertical help
iabbrev DD <C-r>=strftime("%F %r %a")<CR>
iab <expr> tds strftime("%R")

" Select the last set of inserted characters
nnoremap gG `[v`]

" let g:netrw_localrmdir='rm -r'
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 0

""toggle netrw on the left side of the editor
nnoremap <leader>n :Lexplore<CR>
