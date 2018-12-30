#!/bin/bash

DOTFILES=$HOME/.dotfiles
ZSHRC=$HOME/.zshrc
FONTS=$HOME/Library/Fonts
FONT="DejaVuSansMono Nerd Font Mono"

# Update submodules
git submodule update --init --recursive

cp -r $DOTFILES/fonts/nerd-fonts $FONTS
osascript -e "tell application \"Terminal\" to set the font name of window 1 to \"$FONT\""

ln -sv $DOTFILES/zsh/.zshrc $ZSHRC
