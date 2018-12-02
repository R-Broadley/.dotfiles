#!/bin/sh

FONT="DejaVu Sans Mono Nerd Font Complete Mono"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    ln -sv ~/dotfiles/fonts/nerd-fonts ~/Library/Fonts/nerd-fonts
    osascript -e "tell application \"Terminal\" to set the font name of window 1 to \"$FONT\""
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    ln -sv ~/dotfiles/fonts/nerd-fonts ~/.fonts/nerd-fonts
fi

ln -sv ~/dotfiles/zsh/.zshrc ~/.zshrc
