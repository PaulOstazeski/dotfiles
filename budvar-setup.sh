#!/bin/bash -ex
sudo pacman --noconfirm -S zsh tmux
sudo sed -i "/postazeski/ s/bash/zsh/" /etc/passwd 
(
  set +e
  cd ~/.dotfiles/fasd && yes | makepkg -fsicC
)
exit

