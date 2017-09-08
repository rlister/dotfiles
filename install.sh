#!/bin/sh

## clone my config repos
mkdir -p ~/code
cd ~/code
git clone https://github.com/rlister/emacs.d.git
git clone https://github.com/rlister/dotfiles.git

## link emacs
mkdir -p ~/.emacs.d
cd ~/.emacs.d
ln -s ~/code/emacs.d/init.el .