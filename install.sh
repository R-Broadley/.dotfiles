#!/bin/sh

FONT="DejaVuSansMono Nerd Font Mono"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    cp -r ~/dotfiles/fonts/nerd-fonts ~/Library/Fonts
    osascript -e "tell application \"Terminal\" to set the font name of window 1 to \"$FONT\""
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    ln -sv ~/dotfiles/fonts/nerd-fonts ~/.fonts/nerd-fonts
fi

ln -sv ~/dotfiles/zsh/.zshrc ~/.zshrc
