#!/bin/bash

# git
mkdir -p $HOME/.config/git
ln -fnsv $(pwd)/git/ignore $HOME/.config/git/ignore
ln -fnsv $(pwd)/git/.gitconfig $HOME/.gitconfig
ln -fnsv $(pwd)/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
