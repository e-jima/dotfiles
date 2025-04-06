#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
    echo "Not macOS!"
    exit 1
fi

brew bundle --global --file $ZDOTDIR/brew/.Brewfile
brew cleanup