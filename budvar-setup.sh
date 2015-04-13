#!/bin/bash -ex
yes | sudo pacman -S zsh tmux 
sudo sed -i "/postazeski/ s/bash/zsh/" /etc/passwd 
(cd .dotfiles/fasd && yes | makepkg -fsicC) 
exit

