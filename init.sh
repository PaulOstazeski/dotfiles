#!/bin/zsh
typeset -A files
files=(.vim vim .vimrc vim/vimrc .gvimrc vim/gvimrc .tmux.conf tmux.conf .zshrc zshrc .inputrc inputrc .zshenv zshenv .gitconfig gitconfig .psqlrc psqlrc .git_template git_template .crawlrc crawlrc .ctags ctags)

for dotfile sourcefile in ${(kv)files}
do
  if [ -e ~/${dotfile} ]
  then
    mkdir -p original_rc_files
    mv -v ~/${dotfile} original_rc_files/
  fi
  ln -s ~/.dotfiles/${sourcefile} ~/${dotfile}
done

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim ~/.vimrc +PluginInstall +qa

ln -s ~/.dotfiles/Ergodox ~/Ergodox
