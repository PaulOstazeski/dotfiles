set encoding=utf-8
set nocompatible
go
"" To install plug, run
"" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" " Declare the list of plugins.
" All languages, dynamically loaded?
Plug 'sheerun/vim-polyglot'
" A decent-looking colorscheme
Plug 'junegunn/seoul256.vim'
" Any-project navigation like vim-rails
Plug 'tpope/vim-projectionist'
" Rails navigation
Plug 'tpope/vim-rails'
" Better git mergetool
Plug 'whiteinge/diffconflicts'
" Run shell commands like :Remove or :Mkdir
Plug 'tpope/vim-eunuch'
" Run git commands like :Gblame or :Gread
Plug 'tpope/vim-fugitive'
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
" Syntax highlighting for ansible files
Plug 'pearofducks/ansible-vim'
let g:ansible_unindent_after_newline = 1
" Async linting.
" Requires per-language tools (rubocop,eslint) installed outside of vim.
" Better than syntastic b/c async.
Plug 'w0rp/ale'
nnoremap mm :ALENextWrap<CR>
let g:ale_linters = {'ruby': ['rubocop'], 'javascript': ['eslint'], 'elixir': []}
let g:ale_fixers = {'ruby': ['rubocop'], 'javascript': ['eslint'], 'elixir': ['mix_format']}
let g:ale_fixerst = { 'ruby': ['rubocop'] }
let g:ale_fix_on_save = 1
" " List ends here. Plugins become visible to Vim after this call.
call plug#end()

au Filetype elixir let b:dispatch = 'mix test'

au FileType sql setl formatprg=pg_format\ -f\ 1\ -u\ 1\ -
colorscheme seoul256
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

"Fix cron on OSX
"Avoids error 'crontab: temp file must be edited in place'
autocmd FileType crontab set backupskip=/tmp/*,/private/tmp/*
" re-indent xml
map <F3> :%s/>\s*</>\r</g<CR>:set ft=xml<CR>gg=G
" re-indent json
map <F4> :%s/{/{\r/g<CR>:%s/}/\r}/g<CR>:%s/,/,\r/g<CR>:set ft=javascript<CR>gg=G
map <Leader>f ?\<it\\|describe\\|context\><cr>if<esc>:nohlsearch<cr>
map <Leader>g ?\<fit\\|fdescribe\\|fcontext\><cr>x:nohlsearch<cr>

" Make git commits show a preview pane
autocmd! BufReadPost gitcommit
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
autocmd FileType gitcommit setlocal spell spelllang=en_us
autocmd FileType gitcommit DiffGitCached | wincmd L

" Mappings
map QQ :q<CR>
map WW :wall\|:Dispatch<CR>
map NN :next<CR>
map PP :previous<CR>
map VV :w\| :so ~/.vimrc\| :PlugInstall<CR>
" Alias for the sudo write trick, I never remember the exact sequence
cmap SS w !sudo tee %
" Good enough tab completion
imap <Tab> <C-P>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>
nnoremap <CR> :nohlsearch<cr>
cabbrev h vertical help
iabbrev DD <C-r>=strftime("%F %r %a")<CR>
" Select the last set of inserted characters
nnoremap gG `[v`]
