set nocompatible
go
"" To install plug, run
"" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" Terminal acting like gui?
Plug 'wincent/terminus'
" All languages, dynamically loaded?
Plug 'sheerun/vim-polyglot'
" Swap words
Plug 'tommcdo/vim-exchange'
" A decent-looking colorscheme
Plug 'junegunn/seoul256.vim'
" align text by columns - can a code formatter do this for me?
Plug 'godlygeek/tabular'
" Rails navigation
Plug 'tpope/vim-rails'
" Allovue-specific rails projections
let g:rails_projections = {
      \  "acceptance/*_spec.rb": {
      \    "command": "acceptance"
      \  },
      \  "spec/support/*": {
      \    "command": "support"
      \  },
      \ "spec/features/*.feature": {
      \  "command": "feature",
      \  "alternate": "spec/features/step_definitions/%s_steps.rb"
      \ },
      \ "spec/features/step_definitions/*_steps.rb": {
      \  "command": "step",
      \  "alternate": "spec/features/%s.feature"
      \ },
      \ "spec/factories/*.rb": {
      \  "command": "factory",
      \  "affinity": "model"
      \ },
      \ "app/uploaders/*.rb": {
      \  "command": "uploader"
      \ },
      \ "app/admin/*.rb": {
      \  "command": "admin",
      \  "affinity": "model"
      \ },
      \ "app/workers/*.rb": {
      \  "command": "worker"
      \ },
      \ "db/structure.sql": {
      \  "command": "structure",
      \  "affinity": "database"
      \ }
      \}
" Better git mergetool
Plug 'whiteinge/diffconflicts'
" Any-project navigation like vim-rails
Plug 'tpope/vim-projectionist'
" Run shell commands like :Remove or :Mkdir
Plug 'tpope/vim-eunuch'
" Run git commands like :Gblame or :Gread
Plug 'tpope/vim-fugitive'
" Make increment/decrement work on dates
Plug 'tpope/vim-speeddating'
" Recursive directory diff. Rarely needed but indespensible.
Plug 'vim-scripts/DirDiff.vim'
" Supertab? YouCompleteMe?
" Async code completion #TODO: Look into semantic completion, that sounds
" awesome
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Complete text and markdown files
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'unite' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}
" I thought this was part of vim? Mapping for 'surround' actions, like cs"'
" for 'change the surrounding double-quotes to single-quotes
Plug 'tpope/vim-surround'
" Switching among camel/snake/kebob casing
Plug 'tpope/vim-abolish'
" toggle comments
Plug 'tpope/vim-commentary'
" Ember navigation
Plug 'andrewradev/ember_tools.vim'
let g:ember_tools_extract_behaviour = 'component-dir'
" Select and replace multiple words like sublime does
Plug 'terryma/vim-multiple-cursors'
" 'Better' javascript indentation/syntax?
Plug 'pangloss/vim-javascript'
" Make '.' repeat more complicated actions
Plug 'tpope/vim-repeat'
" Tmux syntax
Plug 'keith/tmux.vim'
" Automatically reformat code.
" Requires external tools (per-language: rubocop, jshint)
Plug 'Chiel92/vim-autoformat'
" Filetype detection for ember-style .hbs files
Plug 'mustache/vim-mustache-handlebars'
" Table formatting
Plug 'dhruvasagar/vim-table-mode'
" Mappings for evaluating 'ruby-code #=> ' inline.
" Requires external tool (rcodetools gem)
Plug 't9md/vim-ruby-xmpfilter'
autocmd FileType ruby nmap <buffer> <Leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <Leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <Leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby nmap <buffer> <Leader>n <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <Leader>n <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <Leader>n <Plug>(xmpfilter-run)
" This gives me the "extract assignment into let-binding" for rspec
Plug 'ecomba/vim-ruby-refactoring'
" Copy text from vim to another page
Plug 'jpalardy/vim-slime'
" Set vim-slime to use tmux instead of screen
let g:slime_target = "tmux"
" " Turn on absolute and relative numbers when switching focus
" Plug 'jeffkreeftmeijer/vim-numbertoggle'
" Make 'v' expand to matching pairs without other mappings!?
Plug 'gorkunov/smartpairs.vim'
let g:smartpairs_start_from_word = 1
" Wiki-wiki-what?
Plug 'vimwiki/vimwiki'
" Convert between single and multiple line versions
Plug 'AndrewRadev/splitjoin.vim'
" Syntax highlighting for ansible files
Plug 'pearofducks/ansible-vim'
let g:ansible_unindent_after_newline = 1
" Async linting.
" Requires per-language tools (rubocop,eslint) installed outside of vim. Better than syntastic b/c async.
Plug 'w0rp/ale'
nnoremap mm :ALENextWrap<CR>
let g:ale_linters = {'ruby': ['rubocop']}
let g:ale_fixers = {'ruby': ['rubocop']}
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint']}
" let g:ale_linters = {'ruby': ['standardrb']}
" let g:ale_fixers = {'ruby': ['standardrb']}
" let g:ale_linters = {'javascript': ['standard']}
" let g:ale_fixers = {'javascript': ['standard']}
let g:ale_fix_on_save = 1
Plug 'tmsvg/pear-tree'
" Intelligent auto-close that doesn't break '.'
" Tailwinds/css something?
" Plug 'stephenway/postcss.vim'
" Draggable visual blocks
Plug 'atweiden/vim-dragvisuals'
vmap <expr> <S-LEFT>  DVB_Drag('left')
vmap <expr> <S-RIGHT> DVB_Drag('right')
vmap <expr> <S-DOWN>  DVB_Drag('down')
vmap <expr> <S-UP>    DVB_Drag('up')
vmap <expr>  D        DVB_Duplicate()
" File navigation
Plug 'mhinz/vim-tree'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

au FileType sql setl formatprg=pg_format\ -f\ 1\ -u\ 1\ -
colorscheme seoul256
highlight Comment cterm=italic
" Remove trailing spaces on file save
autocmd BufWritePre     * :%s/\s\+$//e
" Run code files through external formatter
" autocmd BufWrite * :Autoformat

set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set confirm
set encoding=utf8
set expandtab
set history=10000
set hlsearch
set ignorecase
set smartcase
set incsearch
set lazyredraw
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
set virtualedit=block
set wildmenu
set number
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

" Make 81st column stand out
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"Auto open-close quickfix window (make/grep/etc)
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

autocmd FileType gitcommit setlocal spell spelllang=en spellfile=~/.vim/spell/en.utf-8.add
autocmd FileType vimwiki setlocal spell spelllang=en spellfile=~/.vim/spell/en.utf-8.add
"Fix cron on OSX
"Avoids error 'crontab: temp file must be edited in place'
autocmd FileType crontab set backupskip=/tmp/*,/private/tmp/*
" re-indent xml
map <F3> :%s/>\s*</>\r</g<CR>:set ft=xml<CR>gg=G
" re-indent json
map <F4> :%s/{/{\r/g<CR>:%s/}/\r}/g<CR>:%s/,/,\r/g<CR>:set ft=javascript<CR>gg=G
map <Leader>f ?\<it\\|describe\\|context\><cr>if<esc>:nohlsearch<cr>
map <Leader>g ?\<fit\\|fdescribe\\|fcontext\><cr>x:nohlsearch<cr>
" Alias for the sudo write trick, I never remember the exact sequence
cmap sudow w !sudo tee %

" Make git commits show a preview pane
autocmd! BufReadPost gitcommit
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
autocmd FileType gitcommit setlocal spell spelllang=en_us
autocmd FileType gitcommit DiffGitCached | wincmd L
let @d="debugger"

" Mappings
map QQ :q<CR>
map WW :wall<CR>
map NN :next<CR>
map PP :previous<CR>
" map + <C-A>
" map - <C-X>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>
inoremap jk <esc>
nnoremap <CR> :nohlsearch<cr>
cabbrev h vertical help
iabbrev DD <C-r>=strftime("%F %r %a")<CR>
map DD I== <C-r>=strftime("%F %r %a")<CR> ==<CR>
" Select the last set of inserted characters
nnoremap gG `[v`]
nnoremap <Leader>s :mksession<CR>
" nnoremap bn :bn<CR>
" nnoremap bN :bN<CR>
" nnoremap bp :bp<CR>
