# dotfiles

## Overview
This repository contains scripts to set up macOS.

## Required
macOS

## Install
0. Set up your path to clone this repository if you want.
```shell
REPO_ROOT=</path/you/want/to/clone>
```

1. Set up `zsh` configuration.
```shell
/bin/sh -c 'echo "export ZDOTDIR=${REPO_ROOT:-$HOME}/dotfiles" >> ~/.zprofile'
```

2. Build macOS from Makefile 
```shell
cd $REPO_ROOT && git clone https://github.com/e-jima/dotfiles.git && cd dotfiles && make
```

## before replace
```shell
uv pip freeze > $ZDOTDIR/uv/requirements.txt
```