set nocompatible
" To install plug, run
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" A decent-looking colorscheme
Plug 'junegunn/seoul256.vim'
" Consider removing - align text by columns - can a code formatter do this for
" me?
Plug 'Align'
" Async linting.
" Requires per-language tools (rubocop,eslint) installed outside of vim. Better than syntastic b/c async.
Plug 'w0rp/ale'
" Rails navigation
Plug 'tpope/vim-rails'
" Run shell commands like :Remove or :Mkdir
Plug 'tpope/vim-eunuch'
" Run git commands like :Gblame or :Gread
Plug 'tpope/vim-fugitive'
" Make increment/decrement work on dates
Plug 'tpope/vim-speeddating'
" Recursive directory diff. Rarely needed but indespensible.
Plug 'DirDiff.vim'
" Supertab? YouCompleteMe?
" Async code completion #TODO: Look into semantic completion, that sounds
" awesome
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" I thought this was part of vim? Mapping for 'surround' actions, like cs"'
" for 'change the surrounding double-quotes to single-quotes
Plug 'tpope/vim-surround'
" Switching among camel/snake/kebob casing
Plug 'tpope/vim-abolish'
" gcc to toggle comments
" Plug 'tpope/vim-commentary'
Plug 'tomtom/tcomment_vim'
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
" This gives me the "extract assignment into let-binding" for rspec
Plug 'ecomba/vim-ruby-refactoring'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

colorscheme seoul256
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
set history=1000
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
" set number
set list
" Turn on per-folder .vimrc sourcing
set exrc
" Make per-folder .vimrc files safer
set secure
set tabpagemax=99
set directory=~/.vim_swap
set cryptmethod=blowfish2
set equalalways
let mapleader = ','

autocmd FileType gitcommit setlocal spell spelllang=en spellfile=~/.vim/spell/en.utf-8.add
"Fix cron on OSX
"Avoids error 'crontab: temp file must be edited in place'
autocmd FileType crontab set backupskip=/tmp/*,/private/tmp/*
" re-indent xml
map <F3> :%s/>\s*</>\r</g<CR>:set ft=xml<CR>gg=G
" re-indent json
map <F4> :%s/{/{\r/g<CR>:%s/}/\r}/g<CR>:%s/,/,\r/g<CR>:set ft=javascript<CR>gg=G
" Apply rspec focus tag
map <Leader>f :s/ \<do\>$/, focus: true do/<cr><esc>:noh<cr>
map <Leader>g ?focus: true<cr><esc>:s/, focus: true//<cr><esc>:noh<cr>

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
map + <C-A>
map - <C-X>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>
inoremap jk <esc>
nnoremap <CR> :nohlsearch<cr>
" cabbrev h vertical help
iabbrev DD <C-r>=strftime("Paul Ostazeski on %c")<CR>
map DD I== <C-r>=strftime("Paul Ostazeski on %c")<CR> ==<CR>
" Select the last set of inserted characters
nnoremap gG `[v`]
nnoremap <Leader>s :mksession<CR>

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

autocmd FileType ruby nmap <buffer> <Leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <Leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <Leader>m <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <Leader>n <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <Leader>n <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <Leader>n <Plug>(xmpfilter-run)
